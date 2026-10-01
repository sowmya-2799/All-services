variable "project_id" {
  description = "Google Cloud project ID."
  type        = string
}

variable "region" {
  description = "Region for the internal network load balancer."
  type        = string
}

variable "health_check_name" {
  description = "Name of the regional network load-balancer health check."
  type        = string
}

variable "backend_service_name" {
  description = "Name of the regional network load-balancer backend service."
  type        = string
}

variable "address_name" {
  description = "Name of the reserved internal network load-balancer address."
  type        = string
}

variable "forwarding_rule_name" {
  description = "Name of the regional network load-balancer forwarding rule."
  type        = string
}

variable "firewall_name" {
  description = "Name of the network load-balancer backend firewall rule."
  type        = string
}

variable "network_self_link" {
  description = "VPC network self link."
  type        = string
}

variable "subnetwork_self_link" {
  description = "Regional frontend subnet self link."
  type        = string
}

variable "instance_group" {
  description = "Self link of the regional managed instance group backend."
  type        = string
}

variable "backend_tags" {
  description = "Network tags identifying backend instances for the firewall rule."
  type        = list(string)
}

variable "backend_port" {
  description = "HTTP health-check and backend application port."
  type        = number
  default     = 80
}

variable "frontend_port" {
  description = "TCP frontend port."
  type        = number
  default     = 80
}

variable "frontend_ip" {
  description = "Optional internal frontend IPv4 address; null allocates one."
  type        = string
  default     = null
}