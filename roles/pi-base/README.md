image location xz: https://downloads.raspberrypi.com/raspios_lite_arm64/images/raspios_lite_arm64-2024-03-15/2024-03-15-raspios-bookworm-arm64-lite.img.xz
image hash xz: 58a3ec57402c86332e67789a6b8f149aeeb4e7bb0a16c9388a66ea6e07012e45
image hash: 10AAC9ADC0B520F3300646B0D703110E6C163C5A50A5A25C185351589746FFFA
kb
size of bundle: 424192
size of unbundled: 2703360


x64 raspberry pi os lite

# Imaging using rufus
have to unzip the image
FAT32 imaging

## after imaging setup for on the sd card file system
locally 
`openssl passwd -6 -in <filename>`
hash comes out

In the root
- userconf.txt
```
<username>:<hashed_password>
```
- ssh

## Setup on device through ssh after imaging


Packer 1.7.6 with current version fidn it in the 
# Setup linux device
Needs
- Linux
- git
- packer
- packer arm builder plugin
```
sudo apt update
sudo apt install git wget zip unzip build-essential kpartx qemu binfmt-support qemu-user-static e2fsprogs dosfstools
```
install packer
```
export PACKER_VERSION=1.7.6
wget https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip -O /tmp/packer.zip && \
  unzip /tmp/packer.zip -d /bin && \
  rm /tmp/packer.zip
```
install packer-arm-image
```
https://github.com/solo-io/packer-plugin-arm-image/releases/download/v0.2.7/packer-plugin-arm-image_v0.2.7_x5.0_linux_amd64.zip > ~/packer.d/plugins/packer-plugin-arm-image
```
alternative
```
git clone https://github.com/solo-io/packer-plugin-arm-image
go mod download
go build
mv packer-plugin-arm-image ~/.packer.d/plugins/
```
