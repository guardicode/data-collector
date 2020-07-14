# Guardicore data collector

This Tool collects data from given list of servers.

Te tool collects  the following information:

- Hostname
- List of interfaces
- List of running processes
- Dump of connections status (netstat) once in a minute


## Requirements

ansible => 2.9
sshpass


## Usage

```bash
bash collect_data.sh
```