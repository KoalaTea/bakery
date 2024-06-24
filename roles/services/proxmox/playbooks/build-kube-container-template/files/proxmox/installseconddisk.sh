lsblk
fdisk /dev/nvme1n1
> n
> p
> 1
> *enter*
> *enter*
> w
mkfs.ext4 /dev/nvme1n1p1
mkdir /mnt/nvme_storage
mount /dev/nvme1n1p1 /mnt/nvme_storage
echo '/dev/nvme1n1p1 /mnt/nvme_storage ext4 defaults 0 1' >> /etc/fstab
echo "
dir: nvme_storage
    path /mnt/nvme_storage
    content images,iso,vztmpl,backup
    maxfiles 1" >> /etc/pve/storage.cfg

systemctl restart pvedaemon
systemctl restart pveproxy

rm /etc/apt/sources.list.d/pve-enterprise.list
rm /etc/apt/sources.list.d/ceph.list
/etc/apt/sources.list.d/non-enterprise.list
deb http://download.proxmox.com/debian/ceph-quincy bookworm no-subscription
deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription
# Add the Osquery repository
curl -L https://pkg.osquery.io/deb/osquery-apt.pub | apt-key add -
echo "deb [arch=amd64] https://pkg.osquery.io/deb deb main" > /etc/apt/sources.list.d/osquery.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 97A80C63C9D8B80B

# Update package lists
apt update
apt upgrade

# Install Osquery
apt install osquery
# I think this needs to change somehow deprecation warnings
