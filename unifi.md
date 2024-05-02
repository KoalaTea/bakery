unifi - need to install package and remove dependencies on mongo from the dkpg.
Need to install a precompiled mongo or compile one for arm

apt-get download unifi
ar r unifi_7.2.94_sysvinit_all.deb control.tar.gz
sudo dpkg -i unifi_7.2.94_sysvinit_all.deb
install mongo
https://repo.mongodb.org/yum/amazon/2/mongodb-org/6.0/aarch64/RPMS/mongodb-org-server-6.0.6-1.amzn2.aarch64.rpm
Or use the prepackaged one in this repo and remove from control the dependency on mongo

  107  tar zxvf raspbian_mongodb_4.4.8.gz
  108  sudo mv mongo* /usr/bin
    109  sudo chown root:root /usr/bin/mongo*
  110  sudo chmod 755 /usr/bin/mongo*
    111  sudo adduser --no-create-home --disabled-login mongodb
    vi /etc/mongodb.conf
      116  sudo mkdir -p /var/log/mongodb/
        117  sudo chown -R mongodb:mongodb /var/log/mongodb/
  121  sudo chown -R mongodb:mongodb /data/db
  122  sudo vi /lib/systemd/system/mongodb.service
  systemctl start mongodb