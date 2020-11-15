
Instructions
# Guardicore data collectors 
 
What can you find here? 
Tools that collect data from a given list of servers to help you collect the required data for your Attack Surface Report. We have developed two scripts, you can use the one that works best in your environment: 
A script that collects data from servers using an Ansible machine
PsExec script to collect data from servers 
 
In order to use the open source scripts, please follow these instructions: 

## Instructions for Ansible Script:

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

## Instructions for PsExec

1. Download this script to a machine with access to the required machines  https://github.com/guardicode/data-collector/tree/master/PsExec
2. Save a list of IPs, Username and Password in the .ini file as shown in the example (ip,username,password).
- *To use the default username and password from step 3, write "default" instead of the username\password (example in .ini file)
3. Change directory in the CMD to the root folder of the script and execute the script. When prompted, follow the instructions to provide default username and password. 
4. The script will execute for a few min and will create an output tar.gz or zip file.
5. Share the file with Guardicore so we will generate the report. 

### Prerequisites
#### General:
- List of the Remote Machines’ IPs
- User credentials (for each Remote Machine) with elevated permissions that allow execution of commands like 'netstat', 'ps'

#### Linux:
##### Champion Machine:
- putty.exe, pscp.exe (will be provided along with the script, no need to install)
- *Recommendation- 7zip installed in the default path (C:\Program Files\7-Zip\7z.exe), will skip zipping results folder otherwise
#### Remote Machines:
- Port 22 open and network accessible from Champion Machine (or any alternative port in use by sshd daemon)

#### Windows:
##### Same Domain\Workgroup for both champion and remote machines
##### Champion Machine
- Firewall “File and printer sharing” is enabled
- PSexec.exe (will be provided along with the script, no need to install)
- *Recommendation- 7zip installed in the default path (C:\Program Files\7-Zip\7z.exe), will skip zipping results folder otherwise
##### Remote Machines
- Firewall “File and printer sharing” is enabled (Port 445 open and network accessible from Champion Machine)
- $admin share set up correctly to provide access to its \Windows\ folder (normally enabled on Windows machines)

## What it does
1. Collects list of running processes
2. Collects list of interfaces
3. Collects hostname
4. Collects dump of active connections (netstat) periodically every 1 minute for 5 minutes


## FAQs:

 Q: Is anything installed on the target machines? 
 
 A: No.
 

Q: Is there any impact on the machine's performance? 

A: No, the commands executed are extremely lightweight.


Q: Is there any long term impact on the machines or environment? 

A: No. It only collects the data (running processes, list of interfaces, hostname and dump of active connections)

Q: Is my data exposed to Guardicore or any other party after executing this script? 

A: No. The data is being collected to output.tar.gz file / results.zip and will only be available to Guardicore once sent by you. No connection is established at any point to your environment / servers by anyone other than you.  We are also not sharing this data with any external parties. 

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


