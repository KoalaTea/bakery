## Specs for 
https://docs.k3s.io/installation/requirements?os=debian
### nodes
Spec	Minimum	Recommended
CPU	    1 core	2 cores
RAM	    512 MB	1 GB

### servers
CPU and Memory
The following are the minimum CPU and memory requirements for nodes in a high-availability K3s server:

Size	    Nodes	    VCPUS	RAM
Small	    Up to 10	2	    4 GB
Medium	    Up to 100	4	    8 GB
Large	    Up to 250	8	    16 GB
X-Large	    Up to 500	16	    32 GB
XX-Large	500+	    32	    64 GB

### database
K3s supports different databases including MySQL, PostgreSQL, MariaDB, and etcd. See Cluster Datastore for more info.

The following is a sizing guide for the database resources you need to run large clusters:

Deployment Size	Nodes	VCPUS	RAM
Small	Up to 10	1	2 GB
Medium	Up to 100	2	8 GB
Large	Up to 250	4	16 GB
X-Large	Up to 500	8	32 GB
XX-Large	500+	16	64 GB

### Decision
1 Server
3 Agents

## Setting up server
curl -sfL https://get.k3s.io | sh -
K3S_TOKEN in /var/lib/rancher/k3s/server/node-token
kubeconfig at /etc/rancher/k3s/k3s.yaml
https://docs.k3s.io/installation
## Setting up agent
curl -sfL https://get.k3s.io | K3S_URL=https://myserver:6443 K3S_TOKEN=mynodetoken sh -

## install helm?

## example deployment
https://www.jeffgeerling.com/blog/2022/quick-hello-world-http-deployment-testing-k3s-and-traefik

## decided server setup
1 core
4 GB ram
16 GB disk space
0 swap
Static IP
Configured DNS ip address

## Setup for one server kube
manual
### Proxmox setup
cat /proc/sys/net/bridge/bridge-nf-call-iptables
sysctl vm.swappiness=0
swapoff -a
echo 'net.ipv4.ip_forward=1' >> /etc/sysctl.conf
sysctl --system
### PRE KUBE INSTALL ALL NODES
1. Create the CT - uncheck unprivileged container
2. Edit /etc/pve/lxc/\<containerid\>.conf - add lxc_config_additions.txt to the end of it
3. pct push \<containerid\> /boot/config-$(uname -r) /boot/config-$(uname -r)
4. start container
5. Add /usr/local/bin/conf-kmsg.sh
6. Add /etc/systemd/system/conf-kmsg.service
7. run turn-on-kmsg.sh
### First Controller node
1. After PRE KUBE INSTALL ALL NODES steps
2. curl -fsL https://get.k3s.io | sh -s - --disable traefik --node-name \<hostname\>
3. get the /etc/rancher/k3s/k3s.yaml for kubectl config for clients
4. get the /var/lib/rancher/k3s/server/node-token for worker node install
### Worker node
1. After PRE KUBE INSTALL ALL NODES steps
2. After First Controller node node-token is acquired
3. curl -fsL https://get.k3s.io | K3S_URL=https://\<control node ip\>:6443 K3S_TOKEN=\<node-token\> sh -s - --node-name worker-1.k8s
### setup networking - done from a client with the k3s.yaml
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install nginx-ingress ingress-nginx/ingress-nginx --set controller.publishService.enabled=true


##### Potential stuff for kubernetes
Well written, in addition make sure the following kernel modules are loaded from Proxmox Hosts :

br_netfilter
overlay
aufs
ip_vs
nf_nat
xt_conntrack

If you are looking for for a persistent storage controller other than the default Kubernetes local and no external NDS/Gluster/SAN, the only one which is working within LXC/LXD is Kadalu (glusterfs based). (https://github.com/kadalu/kadalu)
Rancher Longhorn or Rook are not working at all.

Another point, if you want a better control of your ingress and egress networks I advise you Calico which is straight forward to put in place on K3s (https://projectcalico.docs.tigera.io/getting-started/kubernetes/k3s/quickstart)
From my side I use Calico with IP in IP overlay.

# some utility commands for kubernetes
kubectl get storageclasses
kubectl exec --stdin --tty <pod name> -- /bin/bash