#GCP variables

variable "project_id" {
  type        = string
  description = "Secure_Serverless_API_Health_Checker"
}

variable "region" {
  type        = string
  default     = "us-central1"
  description = "primary region for resources"
}

variable "vm_name" {
  type        = string
  description = "api_ops"
}
