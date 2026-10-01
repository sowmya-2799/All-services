resource "google_compute_region_health_check" "this" {
  project             = var.project_id
  name                = var.health_check_name
  region              = var.region
  check_interval_sec  = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 2

  http_health_check {
    port         = var.backend_port
    request_path = "/"
  }
}

resource "google_compute_region_backend_service" "this" {
  project               = var.project_id
  name                  = var.backend_service_name
  region                = var.region
  load_balancing_scheme = "INTERNAL"
  protocol              = "TCP"
  health_checks         = [google_compute_region_health_check.this.id]
  session_affinity      = "NONE"

  backend {
    group           = var.instance_group
    balancing_mode  = "CONNECTION"
    capacity_scaler = 1.0
  }
}

resource "google_compute_address" "this" {
  project      = var.project_id
  name         = var.address_name
  region       = var.region
  address_type = "INTERNAL"
  subnetwork   = var.subnetwork_self_link
  address      = var.frontend_ip
}

resource "google_compute_forwarding_rule" "this" {
  project               = var.project_id
  name                  = var.forwarding_rule_name
  region                = var.region
  load_balancing_scheme = "INTERNAL"
  network               = var.network_self_link
  subnetwork            = var.subnetwork_self_link
  ip_address            = google_compute_address.this.self_link
  ports                 = [tostring(var.frontend_port)]
  ip_protocol           = "TCP"
  backend_service       = google_compute_region_backend_service.this.id
}

resource "google_compute_firewall" "backend" {
  project       = var.project_id
  name          = var.firewall_name
  network       = var.network_self_link
  direction     = "INGRESS"
  priority      = 1000
  source_ranges = ["35.191.0.0/16", "130.211.0.0/22"]
  target_tags   = var.backend_tags

  allow {
    protocol = "tcp"
    ports    = [tostring(var.backend_port)]
  }
}