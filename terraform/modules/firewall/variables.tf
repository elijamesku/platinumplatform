variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
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

variable "tags" {
  description = "Tags to apply to resources"
  type        = list(string)
  default     = []
}

