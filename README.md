# SICAS Scripts

Repo containing scripts and tools for development at the SICAS Center. 

## Current scripts

| Script |  | Description | 
| --- | --- | --- |
| [audit](https://github.com/CGBassPlayer/sicas-scripts/blob/master/audit.sh) | [Install](#audit) | Allows developers to look at the audit trail of a jar file file without needing to extract it |

# Installation

### `audit`
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
