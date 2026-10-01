output "name" {
  description = "Name of the regional managed instance group."
  value       = google_compute_region_instance_group_manager.this.name
}

output "instance_group" {
  description = "Self link of the regional managed instance group for backend services."
  value       = google_compute_region_instance_group_manager.this.instance_group
}