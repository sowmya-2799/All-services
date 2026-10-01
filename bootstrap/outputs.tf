output "network_name" {
  description = "Name of the VPC network."
  value       = module.vpc.network_name
}

output "subnetwork_name" {
  description = "Name of the private subnet."
  value       = module.vpc.subnetwork_name
}

output "nat_name" {
  description = "Name of the Cloud NAT gateway."
  value       = module.cloud_nat.nat_name
}

output "vm_name" {
  description = "Name of the Compute Engine VM."
  value       = module.compute_engine.instance_name
}

output "vm_internal_ip" {
  description = "Internal IPv4 address of the VM. The VM has no public IP."
  value       = module.compute_engine.internal_ip
}

output "instance_group_name" {
  description = "Name of the regional managed instance group used by both load balancers."
  value       = module.instance_group.name
}

output "application_load_balancer_ip" {
  description = "Internal frontend IPv4 address of the regional application load balancer."
  value       = module.application_load_balancer.frontend_ip
}

output "network_load_balancer_ip" {
  description = "Internal frontend IPv4 address of the regional passthrough network load balancer."
  value       = module.network_load_balancer.frontend_ip
}

output "bucket_name" {
  description = "Name of the Cloud Storage bucket."
  value       = module.cloud_storage.bucket_name
}

output "psc_endpoint_ip" {
  description = "Internal IPv4 address of the PSC endpoint."
  value       = module.psc.endpoint_ip
}

output "psc_endpoint_name" {
  description = "Name of the PSC endpoint."
  value       = module.psc.endpoint_name
}

output "dns_record_name" {
  description = "Private DNS A-record name for Google APIs."
  value       = module.dns.record_name
}