variable "do_token" {
  description = "DigitalOcean API token"
  type        = string
  sensitive   = true
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "platinumplatform"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "region" {
  description = "Primary DigitalOcean region"
  type        = string
  default     = "nyc3"
}

variable "secondary_region" {
  description = "Secondary DigitalOcean region for DR"
  type        = string
  default     = "sfo3"
}

variable "cluster_name" {
  description = "Name of the Kubernetes cluster"
  type        = string
  default     = "platinum-k8s"
}

variable "node_pool_size" {
  description = "Size of Kubernetes nodes"
  type        = string
  default     = "s-2vcpu-4gb"
}

variable "node_pool_min_nodes" {
  description = "Minimum number of nodes in pool"
  type        = number
  default     = 2
}

variable "node_pool_max_nodes" {
  description = "Maximum number of nodes in pool"
  type        = number
  default     = 10
}

variable "enable_monitoring" {
  description = "Enable monitoring for Kubernetes cluster"
  type        = bool
  default     = true
}

variable "enable_auto_scaling" {
  description = "Enable autoscaling for node pools"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = list(string)
  default     = []
}
