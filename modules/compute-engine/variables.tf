variable "project_id" {
  description = "Google Cloud project ID."
  type        = string
}

variable "zone" {
  description = "Zone in which to create the VM."
  type        = string
}

variable "vm_name" {
  description = "Name of the Compute Engine VM."
  type        = string
}

variable "machine_type" {
  description = "Compute Engine machine type."
  type        = string
}

variable "subnetwork_self_link" {
  description = "Subnetwork self link for the VM network interface."
  type        = string
}

variable "service_account_email" {
  description = "Optional service account email to attach to the VM."
  type        = string
  default     = null
}