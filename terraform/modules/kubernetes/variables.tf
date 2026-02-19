variable "cluster_name" {
  description = "Name of the Kubernetes cluster"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "region" {
  description = "DigitalOcean region"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID to attach cluster to"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.28.2-do.0"
}

variable "system_node_size" {
  description = "Size of system pool nodes"
  type        = string
  default     = "s-2vcpu-4gb"
}

variable "system_node_count" {
  description = "Number of system pool nodes"
  type        = number
  default     = 2
}

variable "app_node_size" {
  description = "Size of app pool nodes"
  type        = string
  default     = "s-4vcpu-8gb"
}

variable "app_node_count" {
  description = "Initial number of app pool nodes"
  type        = number
  default     = 2
}

variable "worker_node_size" {
  description = "Size of worker pool nodes"
  type        = string
  default     = "s-4vcpu-8gb"
}

variable "worker_node_count" {
  description = "Initial number of worker pool nodes"
  type        = number
  default     = 1
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

variable "min_worker_nodes" {
  description = "Minimum nodes in worker pool"
  type        = number
  default     = 1
}

variable "max_worker_nodes" {
  description = "Maximum nodes in worker pool"
  type        = number
  default     = 5
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = list(string)
  default     = []
}

