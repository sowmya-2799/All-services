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