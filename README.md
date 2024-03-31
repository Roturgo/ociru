# ociru: Open Custom IDS Rule Updater
This Bash script downloads custom Suricata rulesets to an OPNsense device. It can be used to add rulesets to your Suricata IDS instance that aren't officially supported or available in the OPNsense GUI.

**NOTE:** This project is in **no** way affiliated with or supported by [OPNsense](https://opnsense.org/) or Deciso B.V. It is simply a helper script written by a happy user of OPNsense and provided to the community as-is, in the hopes that it may be useful.

## Prerequisites
1. Install Bash:
```bash
pkg install bash
```

2. Install cURL:
```bash
pkg install curl
```

## Usage
1. Place the `ociru.sh` script in a location accessible by root's cron daemon, e.g., `/usr/local/sbin/ociru.sh`

2. Test the update script:
```bash
bash /usr/local/sbin/ociru.sh
```

3. (Optional) Add a crontab entry for recurring updates:
```bash
crontab -e
```
Append the following entry to crontab (This example will run at 20:31 every evening):
```bash
31      20      *       *       *       (/usr/local/sbin/ociru.sh) > /dev/null
```

## Rulesets
This script downloads the following rulesets:
* [Etnetera Security - Aggressive IP address feed](https://security.etnetera.cz/feeds/)
* [Travis Green's Suricata Hunting Rules](https://github.com/travisbgreen/hunting-rules)

## Logs
This script appends the output of each run to a log file located at `/var/log/ociru_update.log`