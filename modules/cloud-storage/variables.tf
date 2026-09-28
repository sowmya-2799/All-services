variable "project_id" {
  description = "Google Cloud project ID."
  type        = string
}

variable "bucket_name" {
  description = "Globally unique Cloud Storage bucket name."
  type        = string
}

variable "location" {
  description = "Cloud Storage bucket location."
  type        = string
}

variable "storage_class" {
  description = "Cloud Storage storage class."
  type        = string
  default     = "STANDARD"
}