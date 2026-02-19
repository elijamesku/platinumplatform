variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "region" {
  description = "Primary region"
  type        = string
}

variable "secondary_region" {
  description = "Secondary region"
  type        = string
}

variable "vpc_ip_range" {
  description = "IP range for primary VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "secondary_vpc_ip_range" {
  description = "IP range for secondary VPC"
  type        = string
  default     = "10.1.0.0/16"
}

variable "enable_multi_region" {
  description = "Enable multi-region setup"
  type        = bool
  default     = true
}

