# stores dashboards
resource "synology_filestation_folder" "data" {
  path           = "/docker/grafana/data"
  create_parents = true
}

# stores prometheus metrics
resource "synology_filestation_folder" "prometheus" {
  path           = "/docker/grafana/prometheus"
  create_parents = true
}

# maybe not needed
resource "synology_filestation_folder" "snmp" {
  path           = "/docker/loki/snmp"
  create_parents = true
}
