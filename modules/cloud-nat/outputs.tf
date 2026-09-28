output "nat_name" {
  description = "Cloud NAT gateway name."
  value       = google_compute_router_nat.this.name
}