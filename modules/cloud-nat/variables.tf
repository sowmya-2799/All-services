variable "project_id" {
  description = "Google Cloud project ID."
  type        = string
}

variable "region" {
  description = "Region for the Cloud Router and NAT gateway."
  type        = string
}

variable "name_prefix" {
  description = "Prefix used to name NAT resources."
  type        = string
}

variable "nat_name" {
  description = "Name of the Cloud NAT gateway."
  type        = string
}

variable "network_self_link" {
  description = "VPC network self link where Cloud NAT will be configured."
  type        = string
}