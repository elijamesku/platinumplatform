resource "digitalocean_vpc" "main" {
  name     = "${var.project_name}-vpc-${var.environment}"
  region   = var.region
  ip_range = var.vpc_ip_range
}

resource "digitalocean_vpc" "secondary" {
  count    = var.enable_multi_region ? 1 : 0
  name     = "${var.project_name}-vpc-${var.environment}-secondary"
  region   = var.secondary_region
  ip_range = var.secondary_vpc_ip_range
}

