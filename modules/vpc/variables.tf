variable "project_id" {
  description = "Google Cloud project ID."
  type        = string
}

variable "region" {
  description = "Region for the subnet."
  type        = string
}

variable "network_name" {
  description = "VPC network name."
  type        = string
}

variable "subnetwork_name" {
  description = "Subnet name."
  type        = string
}

variable "network_cidr" {
  description = "IPv4 range for the subnet."
  type        = string
}