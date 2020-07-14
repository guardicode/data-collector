#!/bin/bash


servers_inventory='all:\n  hosts:\n    '
server_index=0
create_inventory_file=true
running_dir=$(pwd)

RESULTS_DIR="$running_dir/results"
SAMPLE_RUNNING_TIME=5

function get_user_y_n_answer(){
    local user_question=$1
    while true; do
        read -p "$user_question" yn
        case $yn in
                [y]* )
                    echo "$yn"
                    break 2;;
                [n]* )
                    echo "$yn"
                    break 2;;
                * ) echo "Please use y or n." >&2;;
        esac
     done
}


function get_running_time_from_user {
        read -p "How long you would like to sample the servers ? for default ($SAMPLE_RUNNING_TIME minutes) press enter  " running_time

        if [ ! -z "$running_time" ]; then
                SAMPLE_RUNNING_TIME="$running_time"
        fi
        echo "Data collecting tool will run for $SAMPLE_RUNNING_TIME minutes"

}


function create_result_directory {
        echo "Please enter a path where we can store the results and the inventory file,"
        read -p "for default ($RESULTS_DIR) press enter ? " new_results_dir

        if [ ! -z "$new_results_dir" ]; then
                RESULTS_DIR="$new_results_dir"
        fi
        echo "Creating results dir $RESULTS_DIR"
        mkdir -p $RESULTS_DIR
        COLLECT_DATA_INVENTORY_FILE="$RESULTS_DIR/servers_inventory"
}


function check_prerequisites {
        echo "Checking ansible version"
        ansible_version=$(python -c 'import ansible; print(ansible.__version__)')
        command_check_status=$?
        if [ "$command_check_status" != "0" ]; then
                echo "Got error while checking Ansible version, please make sure you have Ansible and Python installed"
                exit 1
        fi
        is_ansible_version_valid=$(awk 'BEGIN {print ('"$ansible_version"' >= '2.9') ? "true" : "false" }')
        if [ "$is_ansible_version_valid" != "true" ]; then
                echo "Ansible => 2.9 is needed, please upgrade your ansible version."
                exit 1
        fi
        check_sshpass_exists=$(dpkg -s sshpass)
        sshpass_check_command_status=$?
        if [ "$sshpass_check_command_status" != "0" ]; then
                echo "sshpass is not installed, please install this package "
                exit 1
        fi
}


function get_ansible_inventory_file {
        inventory_exists=$(get_user_y_n_answer "Do you have an existing list of servers from previous running that you would like to re-use ? [y/n] ")
        if [ "$inventory_exists" == "y" ]; then
            read -p 'Please enter the path to the existing list of servers : ' exists_inventory_file
            if [ -f "$exists_inventory_file" ]; then
                    echo "Using existing list of servers $exists_inventory_file"
                    COLLECT_DATA_INVENTORY_FILE=$exists_inventory_file
                    create_inventory_file=false
            else
                    echo "Could not locate the existing list of server, crating a new one instead."
            fi
         fi;

        if [ "$create_inventory_file" == "true" ]; then
                read -p 'Please enter a default username for Windows servers : ' windows_default_user
                read -p 'Please enter a default password for Windows servers : ' windows_default_password
                read -p 'Please enter a default username for Linux servers : ' linux_default_user
                read -p 'Please enter a default password for Linux servers : ' linux_default_password
        fi

        while $create_inventory_file; do
                read -p 'Server Host: ' server_host

                win_server=$(get_user_y_n_answer "Is it a windows server ? [y/n] ")

                default_login=$(get_user_y_n_answer "Use default login details ? [y/n] ")
                if [ "$default_login" == 'y' ]; then
                    if [ "$win_server" == 'y' ]; then
                            server_password="$windows_default_password"
                            server_user="$windows_default_user"
                    else
                            server_password="$linux_default_password"
                            server_user="$linux_default_user"
                    fi
                else
                    read -p 'Server username: ' server_user
                    read -p 'Server password: ' server_password
                fi


                servers_inventory="$servers_inventory""server$server_index:\n      ansible_host: $server_host\n      ansible_user: $server_user\n      ansible_password: $server_password\n      ansible_ssh_common_args: -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null\n    "
                server_index=$(($server_index + 1))

                if [ "$win_server" == 'y' ]; then
                        servers_inventory="$servers_inventory""  ansible_user: $server_user\n      ansible_port: 5986\n      ansible_connection: winrm\n      ansible_winrm_server_cert_validation: ignore\n    "
                fi

                is_more_servers=$(get_user_y_n_answer "Do you wish to add more hosts [y/n] ? ")
                if [ "$is_more_servers" == 'y' ]; then
                    continue;
                else
                    break;
                fi
        done

        if [ "$create_inventory_file" == "true" ]; then
                echo "Saving new inventory file"
                printf  "$servers_inventory" > $COLLECT_DATA_INVENTORY_FILE
        fi
        echo "Using inventory file : $COLLECT_DATA_INVENTORY_FILE"

}

echo "Starting to run"
check_prerequisites
create_result_directory
get_running_time_from_user
get_ansible_inventory_file
echo "Starting to collect data ..."
echo "ansible-playbook $running_dir/collect_data/tasks/main.yml -i $COLLECT_DATA_INVENTORY_FILE -e result_dir=$RESULTS_DIR time_running=$SAMPLE_RUNNING_TIME" --forks=15
ansible-playbook $running_dir/collect_data/tasks/main.yml -i $COLLECT_DATA_INVENTORY_FILE -e "result_dir=$RESULTS_DIR time_running=$SAMPLE_RUNNING_TIME" --forks=15
