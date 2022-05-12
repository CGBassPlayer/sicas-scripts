# SICAS Scripts

Repo containing scripts and tools for development at the SICAS Center. 

## Current scripts

| Script |  | Description | 
| --- | --- | --- |
| [audit](https://github.com/CGBassPlayer/sicas-scripts/blob/master/audit.sh) | [Usage & Install](#audit) | Allows developers to look at the audit trail of a jar file file without needing to extract it |
---

## Installation
`installer.sh` is a script that can automatically install any selection of avaiable scripts onto your system. This script requires checks for [whiptail](https://linux.die.net/man/1/whiptail) and [dos2unix](https://linux.die.net/man/1/dos2unix) to be installed before prompting the scripts install.
```bash
# Install pre-reqs
sudo apt install whiptail dos2unix wget

wget https://raw.githubusercontent.com/CGBassPlayer/sicas-scripts/master/installer.sh -O - | bash
```

## `audit`
#### Manual Installation
To install this script, download it and but it in your local bin directory
```bash
wget https://raw.githubusercontent.com/CGBassPlayer/sicas-scripts/master/audit.sh
mkdir -p ~/bin
mv audit.sh ~/bin/audit
chmod u+x ~/bin/audit
```

To install for all users on the system, install in the `/usr/bin/` directory
```bash
wget https://raw.githubusercontent.com/CGBassPlayer/sicas-scripts/master/audit.sh
sudo mv audit.sh /usr/bin/audit
sudo chmod +x /usr/bin/audit
```
#### Usage
```
Usage: audit -j {file} [options]
    -h  --help          Display this help prompt
    -V  --version       Display version
    -v  --verbose       Show log messages

    -j  --jar {file}    Name of the jar file

    -l  --list          List the editable files in the jar

    -f  --file {file}   Name of the audit trail file. 'AUDIT_TRAIL' is default
    -e  --edit {file}   Edit a specific file inside the jar
    -d  --delete {file} Delete a specific file inside the jar
```
