apt update && apt upgrade -y && apt install vim curl -y
vim /etc/rc.local
chmod +x /etc/rc.local
sudo apt-get install haproxy keepalived -y
vim /etc/haproxy/haproxy.cfg
cat /etc/rancher/k3s/config.yaml
curl -sfL https://get.k3s.io | K3S_TOKEN=<TOKEN> sh -s - server     --server https://10.254.1.1:6443     --tls-san=10.254.1.1
bash install-helm.sh 
helm uninstall traefik traefik-crd -n kube-system
cd /var/lib/rancher/k3s/server/manifests
rm traefik.yaml 
sudo systemctl restart k3s
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
sudo systemctl restart k3s