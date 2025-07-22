terraform {
  required_providers {
    synology = {
      source = "synology-community/synology"
    }
  }
}

provider "synology" {
  host = "https://192.168.1.45:5001"
  user = "koalatea"
}
