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

module "instance_group" {
  source = "../modules/instance-group"

  project_id                    = var.project_id
  region                        = var.region
  name                          = var.instance_group_name
  instance_base_name            = var.backend_instance_base_name
  instance_template_name_prefix = var.backend_instance_template_name_prefix
  machine_type                  = var.machine_type
  subnetwork_self_link          = module.vpc.subnetwork_self_link
  target_size                   = var.instance_group_size
  backend_port                  = var.backend_port
  backend_tags                  = var.backend_tags
  service_account_email         = var.service_account_email

  depends_on = [google_project_service.required]
}

module "application_load_balancer" {
  source = "../modules/application-load-balancer"

  project_id           = var.project_id
  region               = var.region
  health_check_name    = var.application_health_check_name
  backend_service_name = var.application_backend_service_name
  url_map_name         = var.application_url_map_name
  http_proxy_name      = var.application_http_proxy_name
  address_name         = var.application_address_name
  forwarding_rule_name = var.application_forwarding_rule_name
  firewall_name        = var.application_firewall_name
  network_self_link    = module.vpc.network_self_link
  subnetwork_self_link = module.vpc.subnetwork_self_link
  instance_group       = module.instance_group.instance_group
  backend_tags         = var.backend_tags
  backend_port         = var.backend_port
  frontend_port        = var.application_frontend_port
  frontend_ip          = var.application_frontend_ip
  proxy_subnet_name    = var.application_proxy_subnet_name
  proxy_subnet_cidr    = var.application_proxy_subnet_cidr

  depends_on = [google_project_service.required]
}

module "network_load_balancer" {
  source = "../modules/network-load-balancer"

  project_id           = var.project_id
  region               = var.region
  health_check_name    = var.network_health_check_name
  backend_service_name = var.network_backend_service_name
  address_name         = var.network_address_name
  forwarding_rule_name = var.network_forwarding_rule_name
  firewall_name        = var.network_firewall_name
  network_self_link    = module.vpc.network_self_link
  subnetwork_self_link = module.vpc.subnetwork_self_link
  instance_group       = module.instance_group.instance_group
  backend_tags         = var.backend_tags
  backend_port         = var.backend_port
  frontend_port        = var.network_frontend_port
  frontend_ip          = var.network_frontend_ip

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