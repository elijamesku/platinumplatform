output "vpc_id" {
  description = "ID of the primary VPC"
  value       = digitalocean_vpc.main.id
}

output "vpc_urn" {
  description = "URN of the primary VPC"
  value       = digitalocean_vpc.main.urn
}

output "vpc_ip_range" {
  description = "IP range of the primary VPC"
  value       = digitalocean_vpc.main.ip_range
}

output "secondary_vpc_id" {
  description = "ID of the secondary VPC"
  value       = var.enable_multi_region ? digitalocean_vpc.secondary[0].id : null
}

output "secondary_vpc_urn" {
  description = "URN of the secondary VPC"
  value       = var.enable_multi_region ? digitalocean_vpc.secondary[0].urn : null
}

