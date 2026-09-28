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