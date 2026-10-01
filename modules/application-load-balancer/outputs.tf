output "frontend_ip" {
  description = "Internal frontend IPv4 address of the application load balancer."
  value       = google_compute_address.this.address
}

output "forwarding_rule_name" {
  description = "Name of the application load-balancer forwarding rule."
  value       = google_compute_forwarding_rule.this.name
}

output "proxy_subnet_name" {
  description = "Name of the proxy-only subnet required by this load balancer."
  value       = google_compute_subnetwork.proxy_only.name
}