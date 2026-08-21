use build_kube_template.yml to make the kube template then the rest of the ansible scripts can use that. Likely to repeat this pattern for a number of templates or move to using packer and then just uploading that template to my containers. Should look into ansibles ability to manage moving connecting the nas to the cluster

# monitoring
LXC container hostname telegraf 1 Core, 256MB or RAM (will still be able to monitor physical cores attached to the host)
swap 256 is fine
start on boot
apt-get update -y && apt-get upgrade -y
apt-get install -y lm-sensors
verify with
sensors
apt-get install -y wget gpg sudo 
# influxdata-archive_compat.key GPG fingerprint:
#     9D53 9D90 D332 8DC7 D6C8 D3B9 D8FF 8E1F 7DF8 B07E
wget -q https://repos.influxdata.com/influxdata-archive_compat.key
echo '393e8779c89ac8d958f81f942f9ad7fb82a25e133faddaf92e15b16e6ac9ce4c influxdata-archive_compat.key' | sha256sum -c && cat influxdata-archive_compat.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg > /dev/null
echo 'deb [signed-by=/etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg] https://repos.influxdata.com/debian stable main' | sudo tee /etc/apt/sources.list.d/influxdata.list

sudo apt-get update && sudo apt-get install telegraf

cd /etc/telegraf
uncomment telegraf.conf [[inputs.sensors]]
telegraf -config telegraf.conf -test
uncomment the following
[[outputs.influxdb_v2]]
urls
tokens
organization
bucket
timeout
systemctl start telegraf
systemctl enable telegraf
systemctl status telegraf

Greafana
from(bucket: "proxmox")
  |> range(start: v.timeRangeStart, stop: v.timeRangeStop)
  |> filter(fn: (r) => r["_measurement"] == "sensors")
  |> filter(fn: (r) => r["_field"] == "temp_input")
  |> filter(fn: (r) => r["feature"] == "core_0" or r["feature"] == "core_1" or r["feature"] == "core_2" or r["feature"] == "core_3" or r["feature"] == "core_4" or r["feature"] == "core_5" or r["feature"] == "core_6" or r["feature"] == "core_7" or r["feature"] == "core_8" or r["feature"] == "core_12" or r["feature"] == "core_16" or r["feature"] == "core_20" or r["feature"] == "core_32" or r["feature"] == "core_33")
  |> aggregateWindow(every: v.windowPeriod, fn: mean, createEmpty: false)
  |> yield(name: "mean")
  Assign panel title (CPU Core Temperatures) and units in celsius