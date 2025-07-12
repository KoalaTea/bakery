# install nfs-common package for mounting NFS shares if using Ubuntu
apt install nfs-common
# check that the share is available
showmount -e <server>
# create a mount point and mount the share
mkdir /tmp/nfscheck
mount -t nfs <server>:<path> /tmp/nfscheck
# check that the share is mounted
msh@k3s-00:/tmp$ df -h /tmp/nfscheck

# unmount the share once you're done
umount /tmp/nfscheck