variable "project_id" {
  description = "Google Cloud project ID."
  type        = string
}

variable "region" {
  description = "Region for the managed instance group."
  type        = string
}

variable "name" {
  description = "Name of the regional managed instance group."
  type        = string
}

variable "instance_base_name" {
  description = "Base name for instances created by the regional managed instance group."
  type        = string
}

variable "instance_template_name_prefix" {
  description = "Prefix used for instance template names; a generated suffix supports safe template replacement."
  type        = string
}

variable "machine_type" {
  description = "Compute Engine machine type for backend instances."
  type        = string
}

variable "subnetwork_self_link" {
  description = "Regional subnet self link for backend instances."
  type        = string
}

variable "target_size" {
  description = "Number of backend instances to maintain."
  type        = number
  default     = 2
}

variable "backend_port" {
  description = "Named HTTP backend port."
  type        = number
  default     = 80
}

variable "backend_tags" {
  description = "Network tags applied to backend VMs."
  type        = list(string)
  default     = ["sample-backend"]
}

variable "service_account_email" {
  description = "Optional service account email to attach to backend instances."
  type        = string
  default     = null
}