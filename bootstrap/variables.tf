variable "project_id" {
  description = "Google Cloud project ID where resources will be created."
  type        = string
}

variable "region" {
  description = "Default region for regional resources."
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "Zone for the Compute Engine VM."
  type        = string
  default     = "us-central1-a"
}

variable "name_prefix" {
  description = "Prefix used in names for created resources."
  type        = string
  default     = "sample"
}

variable "network_cidr" {
  description = "Primary IPv4 range for the private subnet."
  type        = string
  default     = "10.10.0.0/24"
}

variable "network_name" {
  description = "Name of the VPC network. Changing this replaces the network."
  type        = string
}

variable "subnetwork_name" {
  description = "Name of the regional subnet. Changing this replaces the subnet."
  type        = string
}

variable "machine_type" {
  description = "Compute Engine machine type."
  type        = string
  default     = "e2-micro"
}

variable "vm_name" {
  description = "Name of the Compute Engine VM. Changing this replaces the VM."
  type        = string
}

variable "nat_name" {
  description = "Name of the Cloud NAT gateway. Changing this replaces the gateway."
  type        = string
}

variable "psc_endpoint_name" {
  description = "PSC Google APIs endpoint name: 1-20 lowercase letters/numbers, starting with a letter."
  type        = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9]{0,19}$", var.psc_endpoint_name))
    error_message = "psc_endpoint_name must be 1-20 characters, start with a lowercase letter, and contain only lowercase letters and numbers."
  }
}

variable "psc_endpoint_ip" {
  description = "Unused internal IP address inside network_cidr for the PSC endpoint."
  type        = string

  validation {
    condition     = can(cidrhost("${var.psc_endpoint_ip}/32", 0))
    error_message = "psc_endpoint_ip must be a valid IPv4 address; choose an unused address inside network_cidr."
  }
}

variable "psc_target_bundle" {
  description = "Google APIs PSC target bundle: all-apis or vpc-sc."
  type        = string

  validation {
    condition     = contains(["all-apis", "vpc-sc"], var.psc_target_bundle)
    error_message = "psc_target_bundle must be either all-apis or vpc-sc."
  }
}

variable "dns_zone_name" {
  description = "Cloud DNS managed zone resource name."
  type        = string
}

variable "dns_domain" {
  description = "Private DNS domain for Google APIs; use googleapis.com. with the trailing dot."
  type        = string
}

variable "bucket_name" {
  description = "Globally unique Cloud Storage bucket name."
  type        = string
}

variable "storage_class" {
  description = "Cloud Storage class for the bucket."
  type        = string
  default     = "STANDARD"
}

variable "service_account_email" {
  description = "Optional service account email to attach to the VM."
  type        = string
  default     = null
}

variable "instance_group_name" {
  description = "Name of the regional managed instance group used by both load balancers."
  type        = string
  default     = "sample-backend"
}

variable "backend_instance_base_name" {
  description = "Base name for backend VM instances; Google Cloud adds unique suffixes to individual instances."
  type        = string
  default     = "sample-backend-vm"
}

variable "backend_instance_template_name_prefix" {
  description = "Prefix for the backend instance template; Terraform adds a suffix so template revisions can be replaced safely."
  type        = string
  default     = "sample-backend-template-"
}

variable "instance_group_size" {
  description = "Number of backend instances in the regional managed instance group."
  type        = number
  default     = 2
}

variable "backend_port" {
  description = "HTTP port served by the managed instance group and used by backend health checks."
  type        = number
  default     = 80
}

variable "backend_tags" {
  description = "Network tags applied to backend VMs and used by load-balancer firewall rules."
  type        = list(string)
  default     = ["sample-backend"]
}

variable "application_health_check_name" {
  description = "Name of the regional application load-balancer health check."
  type        = string
  default     = "sample-app-health-check"
}

variable "application_backend_service_name" {
  description = "Name of the regional application load-balancer backend service."
  type        = string
  default     = "sample-app-backend"
}

variable "application_url_map_name" {
  description = "Name of the regional application load-balancer URL map."
  type        = string
  default     = "sample-app-url-map"
}

variable "application_http_proxy_name" {
  description = "Name of the regional application load-balancer HTTP proxy."
  type        = string
  default     = "sample-app-http-proxy"
}

variable "application_address_name" {
  description = "Name of the reserved internal application load-balancer address."
  type        = string
  default     = "sample-app-address"
}

variable "application_forwarding_rule_name" {
  description = "Name of the regional application load-balancer forwarding rule."
  type        = string
  default     = "sample-app-forwarding-rule"
}

variable "application_firewall_name" {
  description = "Name of the firewall rule allowing application LB health checks and proxy traffic."
  type        = string
  default     = "sample-app-allow-health-check-and-proxy"
}

variable "application_frontend_port" {
  description = "Frontend HTTP port for the internal application load balancer."
  type        = number
  default     = 80
}

variable "application_frontend_ip" {
  description = "Optional reserved internal IPv4 address for the application load balancer; null allocates one."
  type        = string
  default     = null
}

variable "application_proxy_subnet_name" {
  description = "Name of the proxy-only subnet required by the regional internal application load balancer."
  type        = string
  default     = "sample-proxy-only"
}

variable "application_proxy_subnet_cidr" {
  description = "Non-overlapping regional CIDR range for the application load balancer proxy-only subnet."
  type        = string
  default     = "10.20.0.0/23"
}

variable "network_health_check_name" {
  description = "Name of the regional network load-balancer health check."
  type        = string
  default     = "sample-network-health-check"
}

variable "network_backend_service_name" {
  description = "Name of the regional network load-balancer backend service."
  type        = string
  default     = "sample-network-backend"
}

variable "network_address_name" {
  description = "Name of the reserved internal network load-balancer address."
  type        = string
  default     = "sample-network-address"
}

variable "network_forwarding_rule_name" {
  description = "Name of the regional network load-balancer forwarding rule."
  type        = string
  default     = "sample-network-forwarding-rule"
}

variable "network_firewall_name" {
  description = "Name of the firewall rule allowing network LB health checks."
  type        = string
  default     = "sample-network-allow-health-check"
}

variable "network_frontend_port" {
  description = "Frontend TCP port for the internal network load balancer."
  type        = number
  default     = 80
}

variable "network_frontend_ip" {
  description = "Optional reserved internal IPv4 address for the network load balancer; null allocates one."
  type        = string
  default     = null
}