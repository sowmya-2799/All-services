locals {
  required_services = toset([
    "compute.googleapis.com",
    "dns.googleapis.com",
    "servicedirectory.googleapis.com",
    "storage.googleapis.com",
  ])
}

resource "google_project_service" "required" {
  for_each = local.required_services

  project                    = var.project_id
  service                    = each.value
  disable_on_destroy         = false
  disable_dependent_services = false
}

module "vpc" {
  source = "../modules/vpc"

  project_id      = var.project_id
  region          = var.region
  network_name    = var.network_name
  subnetwork_name = var.subnetwork_name
  network_cidr    = var.network_cidr

  depends_on = [google_project_service.required]
}

module "cloud_nat" {
  source = "../modules/cloud-nat"

  project_id        = var.project_id
  region            = var.region
  name_prefix       = var.name_prefix
  nat_name          = var.nat_name
  network_self_link = module.vpc.network_self_link
}

module "compute_engine" {
  source = "../modules/compute-engine"

  project_id            = var.project_id
  zone                  = var.zone
  vm_name               = var.vm_name
  machine_type          = var.machine_type
  subnetwork_self_link  = module.vpc.subnetwork_self_link
  service_account_email = var.service_account_email

  depends_on = [google_project_service.required]
}

module "cloud_storage" {
  source = "../modules/cloud-storage"

  project_id    = var.project_id
  bucket_name   = var.bucket_name
  location      = var.region
  storage_class = var.storage_class

  depends_on = [google_project_service.required]
}

module "psc" {
  source = "../modules/psc"

  project_id        = var.project_id
  endpoint_name     = var.psc_endpoint_name
  endpoint_ip       = var.psc_endpoint_ip
  target_bundle     = var.psc_target_bundle
  network_self_link = module.vpc.network_self_link

  depends_on = [google_project_service.required]
}

module "dns" {
  source = "../modules/dns"

  project_id        = var.project_id
  zone_name         = var.dns_zone_name
  dns_name          = var.dns_domain
  record_ip         = module.psc.endpoint_ip
  network_self_link = module.vpc.network_self_link

  depends_on = [google_project_service.required]
}