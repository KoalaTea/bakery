kubectl create ns monitoring
helm install prom prometheus-community/kube-prometheus-stack -n monitoring --values monitoring/values.yaml

kubectl port-forward service/prom-grafana -n monitoring 3000:80 (default is admin/prom-operator)
kubectl get secret/prom-grafana -n monitoring -o json
kubectl port-forward service/prom-kube-prometheus-stack-prometheus -n monitoring 9090:9090

helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
promtail-values.yaml
config:
lokiAddress: "http://loki-loki-distributed-gateway/loki/api/v1/push"
helm upgrade --install promtail grafana/promtail -f monitoring/promtail-values.yaml -n monitoring
helm upgrade --install loki grafana/loki-distributed -n monitoring

helm upgrade prom prometheus-community/kube-prometheus-stack -n monitoring --values monitoring/values.yaml

# helpful
would be useful to get a way for the dashboards to be exported too