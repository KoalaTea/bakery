resource "synology_filestation_folder" "config" {
  path           = "/docker/loki/config"
  create_parents = true
}

resource "synology_filestation_folder" "data" {
  path           = "/docker/loki/data"
  create_parents = true
}
