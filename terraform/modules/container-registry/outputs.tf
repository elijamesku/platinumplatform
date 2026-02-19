output "registry_name" {
  description = "Name of the container registry"
  value       = digitalocean_container_registry.main.name
}

output "registry_endpoint" {
  description = "Endpoint of the container registry"
  value       = digitalocean_container_registry.main.endpoint
}

output "docker_credentials" {
  description = "Docker credentials for the registry"
  value       = digitalocean_container_registry_docker_credentials.main.docker_credentials
  sensitive   = true
}

