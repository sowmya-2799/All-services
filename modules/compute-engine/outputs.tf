output "instance_name" {
  description = "Compute Engine instance name."
  value       = google_compute_instance.this.name
}

output "internal_ip" {
  description = "Internal IPv4 address of the instance."
  value       = google_compute_instance.this.network_interface[0].network_ip
}