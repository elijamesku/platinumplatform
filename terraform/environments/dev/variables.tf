variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "platinumplatform"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "region" {
  description = "Primary DigitalOcean region"
  type        = string
  default     = "nyc3"
}

variable "secondary_region" {
  description = "Secondary DigitalOcean region"
  type        = string
  default     = "sfo3"
}

variable "cluster_name" {
  description = "Name of the Kubernetes cluster"
  type        = string
  default     = "platinum-k8s"
}

variable "enable_auto_scaling" {
  description = "Enable autoscaling for node pools"
  type        = bool
  default     = true
}

variable "min_nodes" {
  description = "Minimum nodes in app pool"
  type        = number
  default     = 2
}

variable "max_nodes" {
  description = "Maximum nodes in app pool"
  type        = number
  default     = 10
}

variable "allowed_ssh_ips" {
  description = "List of IP addresses allowed to SSH"
  type        = list(string)
  default     = []
}

variable "allowed_k8s_ips" {
  description = "List of IP addresses allowed to access Kubernetes API"
  type        = list(string)
  default     = ["0.0.0.0/0", "::/0"]
}

variable "registry_tier" {
  description = "Container registry subscription tier"
  type        = string
  default     = "starter"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = list(string)
  default     = ["dev", "platinumplatform"]
}

