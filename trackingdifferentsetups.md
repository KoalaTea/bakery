## raspberry pi setup
ssh in root
userconf in root filled with
username:hashed-pass
echo 'password' | openssl passwd -6 -stdin

## install unifi gateway
sudo apt update
sudo apt upgrade

sudo apt install openjdk-8-jre-headless
sudo apt install rng-tools

sudo nano /etc/default/rng-tools-debian
replace
#HRNGDEVICE=/dev/hwrng -> HRNGDEVICE=/dev/hwrng

sudo systemctl restart rng-tools


Temporary dealing with missing mongo in bullseye
sudo nano /etc/apt/preferences.d/99stretch-mongodb.pref
add
#Never Prefer packages from Stretch
Package: *
Pin: release n=stretch
Pin-Priority: 1

echo "deb http://archive.raspbian.org/raspbian stretch main" | sudo tee /etc/apt/sources.list.d/stretch_mongodb.list
sudo apt update

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 82B129927FA3303E
sudo apt update

# mongo
# compile on a docker container on my pc if I am going to compile from source
https://andyfelong.com/2021/08/mongodb-4-4-under-raspberry-pi-os-64-bit-raspbian64/

sudo apt-get -y install build-essential nghttp2 libnghttp2-dev libssl-dev git
git clone -b r4.4.8 https://github.com/mongodb/mongo.git
tar zxvf raspbian_mongodb_4.4.8.gz
sudo mv mongo* /usr/bin0
sudo chown root:root /usr/bin/mongo*
sudo chmod 755 /usr/bin/mongo*
sudo adduser --no-create-home --disabled-login mongodb

sudo vi /etc/mongodb.conf
```
# mongod.conf

# for documentation of all options, see:
#   http://docs.mongodb.org/manual/reference/configuration-options/

# where to write logging data.
systemLog:
  destination: file
  logAppend: true
  path: /var/log/mongodb/mongod.log

# Where and how to store data.
storage:
  dbPath: /data/db
  journal:
    enabled: true
#  engine:
#  wiredTiger:

# network interfaces
net:
  port: 27017
  bindIp: 127.0.0.1  # Enter 0.0.0.0,:: to bind to all IPv4 and IPv6 addresses


#security:

#operationProfiling:

#replication:

#sharding:

## Enterprise-Only Options

#auditLog:

#snmp:
```
sudo mkdir -p /var/log/mongodb/
sudo chown -R mongodb:mongodb /var/log/mongodb/
sudo mkdir /data
sudo chmod 777 /data
sudo mkdir -p /data/db
sudo chown -R mongodb:mongodb /data/db
sudo vi /lib/systemd/system/mongodb.service
```
[Unit]
Description=An object/document-oriented database
Documentation=man:mongod(1)
After=network.target

[Service]
User=mongodb
Group=mongodb
# Other directives omitted
# (file size)
LimitFSIZE=infinity
# (cpu time)
LimitCPU=infinity
# (virtual memory size)
LimitAS=infinity
# (locked-in-memory size)
LimitMEMLOCK=infinity
# (open files)
LimitNOFILE=64000
# (processes/threads)
LimitNPROC=64000
ExecStart=/usr/bin/mongod --quiet --config /etc/mongodb.conf

[Install]
WantedBy=multi-user.target
```
$ sudo service mongodb start
$ sudo service mongodb status

sudo fallocate -l 4G /swapfile
ls -lh /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo cp /etc/fstab /etc/fstab.bak
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

# idk
echo 'deb [signed-by=/usr/share/keyrings/ubiquiti-archive-keyring.gpg] https://www.ui.com/downloads/unifi/debian stable ubiquiti' | sudo tee /etc/apt/sources.list.d/100-ubnt-unifi.list
curl https://dl.ui.com/unifi/unifi-repo.gpg | sudo tee /usr/share/keyrings/ubiquiti-archive-keyring.gpg >/dev/null
sudo apt update
sudo apt install unifi


## the raspberry pi tpm zymkey 4
We will not set production mode because it getting swapped hardware is not in my personal threat model
plug into pins 1-10 (top side of the gpio pins)

enable arm i2c interface
zymkey default address ix 0x30
stuck on waiting for support of bullseye
https://docs.zymbit.com/getting-started/zymkey4/quickstart/

apt download unifi
dpkg --force-depends --install

```
sudo raspi-config
interfrace options -> I2C -> ARM I2C enabled (yes) -> zymkey default address 0x30
curl -G https://s3.amazonaws.com/zk-sw-repo/install_zk_sw.sh | sudo bash

sudo su
wake_pin=`grep GPIO4 /sys/kernel/debug/gpio | sed -r 's/[^0-9]*([0-9]*).*/\1/'`
echo "wake_pin=$wake_pin"   # sanity check value is set
echo "ZK_GPIO_WAKE_PIN=$wake_pin" > /var/lib/zymbit/zkenv.conf
systemctl restart zkifc
```
```
curl -L -o examples.zip https://community.zymbit.com/uploads/short-url/eUkHVwo7nawfhESQ3XwMvf28mBb.zip
unzip examples.zip
python3 zk_app_utils_test.py
```
c packages from the install script so I can try to cgo
packages for messing with things might be arm only this stuff likely more annoying
```
apt install -y libzk libzymkeyssl zkbootrtc zkifc zkapputilslib zksaapps zkpkcs11 cryptsetup &>/dev/null || exit
apt install -y cryptsetup-initramfs cryptsetup-run &>/dev/null
```
# packer stuff
I think it might be interesting to have salt and osquery. (OSQuery does not support ARM and has no plans)

# network stuff
istio envoy - istio provides the control plane passing information to the envoy proxies and giving them configuration

# maybe useful
ansible-vault create vault.yml