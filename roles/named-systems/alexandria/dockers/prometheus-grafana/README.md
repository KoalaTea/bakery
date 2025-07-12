general information comes from
https://github.com/wozniakpawel/synology-grafana-prometheus-overly-comprehensive-dashboard/tree/main

Basically what is needed is the system needs to be accessible firewall wise.
SNMP v3 needs to be enabled, and the snmp.yml needs to be edited to have the correct information to authenticate to it. Passwords may have problems with special characters
Prometheus needs to be configured to know how to ask snmp-exporter to target itself using the values in its configuration which is changing the target in prometheus.yml to the nas ip.
Need to setup the file system on the NAS, transfer the files, and setup the docker-compose.
```files
docker/
    grafana/
        prometheus.yml
        snmp.yml
        prometheus/
        snmp/
        grafana/
```
grafana needs to be logged into <ip>:3340
add a promehteus data source using the internal compose network address prometheus:9090 click save and test
import dashboard Synology_Dashboard.json selecting the datasource.

The dockers require pretty high permissions to correctly be able to access the data from the mounted sys files. Should look at what I can limit and where.

# needed folders
data
prometheus
snmp