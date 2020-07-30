# Guardicore data collector
 
 This tool collects data from a given list of servers to help you collect the required data for your Segmentation Impact Report
 
In order to use the open source script, please follow these instructions: 

### Instructions

1. Download this script to a machine with Ansible =>2.9 
    https://github.com/guardicode/data-collector
2. Execute and follow the instructions to provide the list of machines in the target application and access credentials. 
3. An inventory (a file that includes all the target machines) will be created with the script in the first run. This will enable you, after the 1st run, to use this inventory (that is saved in the results dir) for more runs instead of providing again all the target machine details. For details about inventory, see the [a following page](https://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html).
4. The script will execute for a few min and will create an output tar.gz file.
5. The file needs to be sent to Guardicore and we will generate the report. 


### Prerequisites:

1. Ansible => 2.9 on the machine where the script is executed
2. sshpass on the machine where the script is executed
3. The credentials allow execution of commands like 'netstat', 'ps'


### What it does:

1. Collects list of running processes
2. Collects list of interfaces
3. Collects hostname
4. Collects dump of active connections (netstat) periodically every 1 minute for 5 minutes


### FAQs:

 Q: Is anything installed on the target machines? 
 
 A: No.
 

Q: Is there any impact on the machine's performance? 

A: No, the commands executed are extremely lightweight.


Q: Is there any long term impact on the machines or environment? 

A: No. It only collects the data (running processes, list of interfaces, hostname and dump of active connections)

Q: Is my data exposed to Guardicore or any other party after executing this script? 

A: No. The data is being collected to output.tar.gz file and will only be available to Guardicore once sent by you. No connection is established at any point to your environment / servers by anyone other than you.  We are also not sharing this data with any external parties. 

Q: Is it OK if I do not have access to all of the application’s machines but only some? 

A: Yes, but full coverage will provide better accuracy

Q: What other options are there if I can not run this script? 

A:   

- Netflow from the relevant network - needs to capture the traffic of the relevant app
- Pcap file from the relevant network - needs to capture the traffic of the relevant app
- Just execute the commands manually (or by your own script) and send us the output 
- We can help with tailored solution if you have unique requirements 


## Usage

```bash
bash collect_data.sh
```
