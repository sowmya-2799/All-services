# Project and deployment location
project_id = "sonata-gcp-delivery"
region     = "asia-south1"
zone       = "asia-south1-a"

# VPC module
name_prefix     = "sample"
network_name    = "sample-vpc"
subnetwork_name = "sample-subnet"
network_cidr    = "10.10.0.0/24"

# Compute Engine module
machine_type = "e2-micro"
vm_name      = "sample-vm"

# Regional managed instance-group backend and internal load balancers
instance_group_name                   = "sample-backend"
instance_group_size                   = 2
backend_instance_base_name            = "sample-backend-vm"
backend_instance_template_name_prefix = "sample-backend-template-"
backend_port                          = 80
backend_tags                          = ["sample-backend"]
application_health_check_name         = "sample-app-health-check"
application_backend_service_name      = "sample-app-backend"
application_url_map_name              = "sample-app-url-map"
application_http_proxy_name           = "sample-app-http-proxy"
application_address_name              = "sample-app-address"
application_forwarding_rule_name      = "sample-app-forwarding-rule"
application_firewall_name             = "sample-app-allow-health-check-and-proxy"
application_frontend_port             = 80
application_proxy_subnet_name         = "sample-proxy-only"
application_proxy_subnet_cidr         = "10.20.0.0/23"
network_health_check_name             = "sample-network-health-check"
network_backend_service_name          = "sample-network-backend"
network_address_name                  = "sample-network-address"
network_forwarding_rule_name          = "sample-network-forwarding-rule"
network_firewall_name                 = "sample-network-allow-health-check"
network_frontend_port                 = 80

# Cloud NAT module
nat_name = "sample-nat"

# Optional VM service account
service_account_email = null

# Cloud Storage module
bucket_name   = "piramal-test"
storage_class = "STANDARD"

# Global PSC endpoint for Google APIs; select an unused address inside network_cidr.
psc_endpoint_name = "samplegooglepsc"
psc_endpoint_ip   = "10.10.0.10"
psc_target_bundle = "all-apis"

# Private DNS zone for standard Google API hostnames.
dns_zone_name = "googleapis-private-zone"
dns_domain    = "googleapis.com."