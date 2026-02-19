resource "digitalocean_container_registry" "main" {
  name                   = "${var.project_name}-registry-${var.environment}"
  subscription_tier_slug = var.registry_tier
}

resource "digitalocean_container_registry_docker_credentials" "main" {
  registry_name = digitalocean_container_registry.main.name
}

