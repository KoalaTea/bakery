NAS

containers?
docker run -d \
  --name homeassistant \
  --privileged \
  --restart=unless-stopped \
  -e TZ=MY_TIME_ZONE \
  -v /PATH_TO_YOUR_CONFIG:/config \
  --network=host \
  ghcr.io/home-assistant/home-assistant:stable

  Honestly its probably not the best place for these things, set it up as a nas mini computer coming later for kube

# NAS extras
## File station
Create folders for both docker and nfs
## Package Center
Install Container Manager
## NFS
Control Panel -> File Services -> NFS
Enable and highest version
Control Panel -> Shared Folder -> Click Folder for NFS -> Edit -> Top tab NFS Permissions -> Create
*, Read/Write, Mapp all users to admin, sys, all checks.
This is a hack to just get it to work but definitely not actually secure should have real permissions
## Grafana/prometheus SNMP
### Firewall
Security -> Firewall. If off anything will work since there is no firewall
If on
Firewall profile -> Edit Rules -> Create
Ports All, Select a specific IP, 172.22.0.0 255.255.0.0, Action Allow
### SNMP Exporter
Control Panel -> Terminal and SNMP -> SNMP
Enable SNMP Service, SNMPv3, MD5, new password, Enable SNMP privacy, DES, new second password
edit snmp.yml, replace snmpv3_password_placeholder, snmp_priv_password_placeholder, keep quotation marks
### Prometheus
replace your_real_host_ip with nas ip
### compose.yml
All the userid:group_ids need to be recplaced with docker user running docker

The folders REQUIRED Everyone Read Write permissions. Something strange on that part. probably why the user ids was needed but still strange