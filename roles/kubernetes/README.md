# Role Name

Sets up a single node kubernetes cluster.

What the role does is

- disables swap because kubernetes requires it off
- installs docker as the CRI (container runtime interface) giving kubernetes a container system to manage and work with
- installs the kubeadm for bootstraping the cluster
- installs kubelet for running kubernetes
- installs kubectl for managing the cluster
- links resolv.conf to the systemd resolv so containers get the right dns (I think specifically coredns container needs this maybe others)
- sets up servers root account for admin privs on the cluster
- installs Calico as the ONI for kubernetes
- removes the master taint so that the master also acts like a node making it a single node cluster
- sets up nfs as a storageclass for PVC (persistent storage claims) and deploys a container providing nfs so that deployments can have persistent storage (such as the next step) [nfs-files-readme](files/nfs-dynamic-storage/README.md)
- sets up a docker registry container that uses the nfs storage because a registry is required to deploy containers to kubernetes

## Requirements

Any pre-requisites that may not be covered by Ansible itself or the role should be mentioned here. For instance, if the role uses the EC2 module, it may be a good idea to mention in this section that the boto package is required.

## Role Variables

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

## Dependencies

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

## Example Playbook

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: username.rolename, x: 42 }

## License

BSD

## Author Information

An optional section for the role authors to include contact information, or a website (HTML is not allowed).
