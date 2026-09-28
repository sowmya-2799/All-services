output "zone_name" {
  description = "Private Cloud DNS managed zone resource name."
  value       = google_dns_managed_zone.private.name
}

output "record_name" {
  description = "Private DNS A-record name for Google APIs."
  value       = google_dns_record_set.googleapis_apex.name
}