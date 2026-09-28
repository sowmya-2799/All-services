output "endpoint_name" {
  description = "PSC consumer endpoint forwarding rule name."
  value       = google_compute_global_forwarding_rule.endpoint.name
}

output "endpoint_ip" {
  description = "Internal IP address reserved for the PSC endpoint."
  value       = google_compute_global_address.endpoint.address
}