resource "google_compute_subnetwork" "proxy_only" {
  project       = var.project_id
  name          = var.proxy_subnet_name
  region        = var.region
  network       = var.network_self_link
  ip_cidr_range = var.proxy_subnet_cidr
  purpose       = "REGIONAL_MANAGED_PROXY"
  role          = "ACTIVE"
}

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
  load_balancing_scheme = "INTERNAL_MANAGED"
  protocol              = "HTTP"
  port_name             = "http"
  timeout_sec           = 30
  health_checks         = [google_compute_region_health_check.this.id]

  backend {
    group           = var.instance_group
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }
}

resource "google_compute_region_url_map" "this" {
  project         = var.project_id
  name            = var.url_map_name
  region          = var.region
  default_service = google_compute_region_backend_service.this.id
}

resource "google_compute_region_target_http_proxy" "this" {
  project = var.project_id
  name    = var.http_proxy_name
  region  = var.region
  url_map = google_compute_region_url_map.this.id
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
  load_balancing_scheme = "INTERNAL_MANAGED"
  network               = var.network_self_link
  subnetwork            = var.subnetwork_self_link
  ip_address            = google_compute_address.this.self_link
  port_range            = tostring(var.frontend_port)
  target                = google_compute_region_target_http_proxy.this.id
}

resource "google_compute_firewall" "backend" {
  project   = var.project_id
  name      = var.firewall_name
  network   = var.network_self_link
  direction = "INGRESS"
  priority  = 1000

  source_ranges = concat(
    ["35.191.0.0/16", "130.211.0.0/22"],
    [google_compute_subnetwork.proxy_only.ip_cidr_range],
  )
  target_tags = var.backend_tags

  allow {
    protocol = "tcp"
    ports    = [tostring(var.backend_port)]
  }
}