resource "google_compute_network" "this" {
  project                 = var.project_id
  name                    = var.network_name
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}

resource "google_compute_subnetwork" "this" {
  project                  = var.project_id
  name                     = var.subnetwork_name
  region                   = var.region
  network                  = google_compute_network.this.id
  ip_cidr_range            = var.network_cidr
  private_ip_google_access = true
}