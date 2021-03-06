# Guardicore data collector
 
This tool collects data from a given list of servers to help you collect the required data for your Segmentation Impact Report
 
In order to use the open source script, please follow these instructions: 

### Instructions

1. Download this script to a champion machine with access to the remote machines
2. Save a list of IPs, Username and Password in the .ini file as shown in the example.
    * To use the default username and password from step 3, write "default" instead of the username\password (example in .ini file)
3. Change directory in the CMD to the root folder of the script and execute the script. When prompted, follow the instructions to provide default username and password. 
4. The script will execute for a few min and will create an output tar.gz or zip file.
5. Please password protect the file you send via email to: **risk_reduction@guardicore.com** without the password! We will reach back to you in order to receive the PW via SMS / secure msg app.



### Prerequisites:

#### General:
- List of the Remote Machines’ IPs
- User credentials (for each Remote Machine) with elevated permissions that allow execution of commands like 'netstat', 'ps'
#### Linux:
**Champion Machine:**
- putty.exe, pscp.exe (will be provided along with the script, no need to install)
- *Recommendation- 7zip installed in the default path (C:\Program Files\7-Zip\7z.exe), will skip zipping results folder otherwise

**Remote Machines:**
- Port 22 open and network accessible from Champion Machine (or any alternative port in use by sshd daemon)


#### Windows:
- Same Domain\Workgroup for both champion and remote machines

**Champion Machine**
- Firewall “File and printer sharing” is enabled
- PSexec.exe (will be provided along with the script, no need to install)
- *Recommendation- 7zip installed in the default path (C:\Program Files\7-Zip\7z.exe), will skip zipping results folder otherwise

**Remote Machines**
- Firewall “File and printer sharing” is enabled (Port 445 open and network accessible from Champion Machine)
- $admin share set up correctly to provide access to its \Windows\ folder (normally enabled on Windows machines)



### What it does:

1. Collects list of running processes
2. Collects list of interfaces
3. Collects hostname
4. Collects list of listening ports
5. Collects dump of active connections (netstat) periodically every 1 minute for 5 minutes


### FAQs:

Q:  Will anything be installed on the remote machines? 
 
A: No.
 

Q: Is there any impact on the machine's performance? 

A: No, the commands executed are extremely lightweight.


Q: Is there any long term impact on the machines or environment? 

A: No. It only collects the data (running processes, list of interfaces, hostname and dump of active connections)

Q: Is my data exposed to Guardicore or any other party after executing this script? 

A: No. The data is being collected to results.zip file and will only be available to Guardicore once sent by you. No connection is established at any point to your environment / servers by anyone other than you.  We are also not sharing this data with any external parties. 

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
data_collector.bat
```
