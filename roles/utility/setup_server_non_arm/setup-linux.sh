# Pre setup
apt update
apt upgrade

# Install
curl -L https://pkg.osquery.io/deb/osquery-apt.pub | apt-key add -
echo "deb [arch=amd64] https://pkg.osquery.io/deb deb main" > /etc/apt/sources.list.d/osquery.list
apt update
apt install osquery

# verification
osqueryd --version

# configure Configure Osquery
nano /etc/osquery/osquery.conf
{
  "options": {
    "config_plugin": "filesystem",
    "logger_plugin": "filesystem",
    "events_plugin": "filesystem",
    "host_identifier": "hostname"
  },
  "schedule": {
    "system_info": {
      "query": "SELECT * FROM system_info;",
      "interval": 3600
    }
  }
}

# Start Osquery Daemon
systemctl start osqueryd
systemctl enable osqueryd

# Verify Osquery Operation
systemctl status osqueryd
journalctl -u osqueryd

# Usage and integration. For ad-hoc queries 
osqueryi

# Additional Considerations
## Security: Ensure Osquery is configured securely, especially if you're monitoring sensitive infrastructure.
## Performance: Monitor the performance impact of Osquery on your Proxmox nodes, especially in production environments.