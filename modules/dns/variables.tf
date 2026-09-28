variable "project_id" {
  description = "Google Cloud project ID."
  type        = string
}

variable "zone_name" {
  description = "Cloud DNS managed zone resource name."
  type        = string
}

variable "dns_name" {
  description = "DNS suffix for the private managed zone, including the trailing dot."
  type        = string
}

variable "record_ip" {
  description = "Internal IP address to publish in the DNS record."
  type        = string
}

variable "network_self_link" {
  description = "VPC network self link that can resolve the private DNS zone."
  type        = string
}

