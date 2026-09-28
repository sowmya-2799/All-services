resource "google_compute_global_address" "endpoint" {
  project      = var.project_id
  name         = "${var.endpoint_name}-ip"
  address      = var.endpoint_ip
  address_type = "INTERNAL"
  purpose      = "PRIVATE_SERVICE_CONNECT"
  network      = var.network_self_link
}

resource "google_compute_global_forwarding_rule" "endpoint" {
  project               = var.project_id
  name                  = var.endpoint_name
  network               = var.network_self_link
  ip_address            = google_compute_global_address.endpoint.id
  target                = var.target_bundle
  load_balancing_scheme = ""
}