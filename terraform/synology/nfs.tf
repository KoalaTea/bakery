# folder for nfs
resource "synology_filestation_folder" "data" {
  path           = "/nfsstorage"
  create_parents = true
}
