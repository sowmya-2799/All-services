variable "project_id" {
  description = "Google Cloud project ID."
  type        = string
}

variable "endpoint_name" {
  description = "Global PSC endpoint forwarding rule resource name."
  type        = string
}

variable "endpoint_ip" {
  description = "Unused internal IP address to reserve for the PSC endpoint."
  type        = string
}

variable "target_bundle" {
  description = "Google APIs target bundle: all-apis or vpc-sc."
  type        = string
}

variable "network_self_link" {
  description = "VPC network self link for the PSC endpoint."
  type        = string
}
