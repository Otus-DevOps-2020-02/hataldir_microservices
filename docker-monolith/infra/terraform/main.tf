provider "google" {
  version = "~>2.15"
  project = var.project
  region  = var.region
  zone    = var.zone
}


module "dk" {
  source          = "./modules/dk"
  public_key_path = var.public_key_path
  zone             = var.zone
  app_disk_image   = var.app_disk_image
  private_key_path = var.private_key_path
  app-count	   = 2
}

