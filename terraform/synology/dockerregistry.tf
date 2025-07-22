# stores images
resource "synology_filestation_folder" "data" {
  path           = "/docker/dockerregistry/data"
  create_parents = true
}
