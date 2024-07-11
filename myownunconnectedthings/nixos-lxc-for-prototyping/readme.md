# Making nixos lxc container
Need to sudo before running add_nixos_lxc_to_templates.yml playbook. Also requires a ini like ansible_control_files/proxmox_inventory.ini.example

## Where this comes from
https://nixos.wiki/wiki/Proxmox_Virtual_Environment

## base command
The following command creates a tarball of an lxc nixos for proxmox
nix run github:nix-community/nixos-generators -- --format proxmox-lxc

## Outputs
### stdout
1> <somewhere>
holds the path - so stdout has the path output for use else where

### -o option
nix run github:nix-community/nixos-generators -- --format proxmox-lxc -o nixos-lxc-tarball
makes nixos-lxc-tarball symbolic link
has folder tarball
under which is the actual tarball
nixos-system-x86_64-linux.tar.xz
nixos-lxc-tarball/tarball/nixos-system-x86_64-linux.tar.xz