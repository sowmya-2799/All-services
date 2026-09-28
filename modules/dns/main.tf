resource "google_dns_managed_zone" "private" {
  project    = var.project_id
  name       = var.zone_name
  dns_name   = var.dns_name
  visibility = "private"

  private_visibility_config {
    networks {
      network_url = var.network_self_link
    }
  }
}

resource "google_dns_record_set" "googleapis_apex" {
  project      = var.project_id
  managed_zone = google_dns_managed_zone.private.name
  name         = var.dns_name
  type         = "A"
  ttl          = 300
  rrdatas      = [var.record_ip]
}

resource "google_dns_record_set" "googleapis_wildcard" {
  project      = var.project_id
  managed_zone = google_dns_managed_zone.private.name
  name         = "*.${var.dns_name}"
  type         = "CNAME"
  ttl          = 300
  rrdatas      = [var.dns_name]
}