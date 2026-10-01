output "frontend_ip" {
  description = "Internal frontend IPv4 address of the network load balancer."
  value       = google_compute_address.this.address
}

output "forwarding_rule_name" {
  description = "Name of the network load-balancer forwarding rule."
  value       = google_compute_forwarding_rule.this.name
}