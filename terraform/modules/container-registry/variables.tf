variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "registry_tier" {
  description = "Container registry subscription tier"
  type        = string
  default     = "starter"
}

