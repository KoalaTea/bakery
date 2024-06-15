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

chmod 0644 .pub files
## Certs setup
ssh-keygen -t rsa -b 4096 -f host_ca -C host_ca
ssh-keygen -t rsa -b 4096 -f user_ca -C user_ca
chmod 0600 host_ca
chmod 0600 user_ca
ssh-keygen -f ssh_host_rsa_key -N '' -b 4096 -t rsa
ssh-keygen -s host_ca -I host.example.com -h -n host.example.com -V +52w ssh_host_rsa_key.pub
ssh-keygen -f user-key -b 4096 -t rsa
ssh-keygen -s user_ca -I honda@goteleport.com -n koalatea -V +1d user-key.pub

## Setup on device through ssh after imaging
copy over host cert and host private key
copy over user CA cert
- /etc/ssh/sshd_config
```
HostCertificate /etc/ssh/ssh_host_rsa_key-cert.pub
TrustedUserCAKeys /etc/ssh/user_ca.pub
```
`systemctl restart sshd`


## Setup on ssh client
CA between @cer-authority and host_ca
- ~/.ssh/known_hosts
```
@cert-authority 192.168.1.101 <host_ca.pub>
```

```
ssh-keygen -L -f user-key-cert.pub
user-key-cert.pub:
        Type: ssh-rsa-cert-v01@openssh.com user certificate
        Public key: RSA-CERT SHA256:egWNu5cUZaqwm76zoyTtktac2jxKktj30Oi/ydrOqZ8
        Signing CA: RSA SHA256:tltbnMalWg+skhm+VlGLd2xHiVPozyuOPl34WypdEO0 (using ssh-rsa)
        Key ID: "honda@goteleport.com"
        Serial: 0
        Valid: from 2020-03-19T16:33:00 to 2020-03-20T16:34:54
        Principals:
                ec2-user
                honda
        Critical Options: (none)
        Extensions:
                permit-X11-forwarding
                permit-agent-forwarding
                permit-port-forwarding
                permit-pty
                permit-user-rc
```

Packer 1.7.6 with current version find it in the Docker file
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

Extra
```
    {
      "type": "shell",
      "inline": [
        "echo 'Install APT Packages'",
        "echo nameserver 8.8.8.8 > /etc/resolv.conf",
        "apt-get update",
        "apt-get -y install --no-install-recommends xserver-xorg-video-all xserver-xorg-input-all xserver-xorg-core xinit x11-xserver-utils fbi curl",
        "rm -f /etc/motd",
        "chown pi:pi -R /home/pi/"
      ]
    },
    {
      "type": "shell",
      "script": "./scripts/run.sh"
    }
```
