# Production environment configuration
# Similar to dev but with production-grade settings

module "vpc" {
  source = "../../modules/vpc"

  project_name      = var.project_name
  environment       = var.environment
  region            = var.region
  secondary_region  = var.secondary_region
  enable_multi_region = true
}

module "firewall" {
  source = "../../modules/firewall"

  project_name     = var.project_name
  environment      = var.environment
  allowed_ssh_ips  = var.allowed_ssh_ips
  allowed_k8s_ips  = var.allowed_k8s_ips
  tags             = var.tags
}

module "kubernetes" {
  source = "../../modules/kubernetes"

  cluster_name        = var.cluster_name
  environment         = var.environment
  region              = var.region
  vpc_id              = module.vpc.vpc_id
  enable_auto_scaling = var.enable_auto_scaling
  min_nodes           = var.min_nodes
  max_nodes           = var.max_nodes
  
  # Production: Larger nodes
  app_node_size     = "s-8vcpu-16gb"
  worker_node_size  = "s-8vcpu-16gb"
  system_node_size  = "s-4vcpu-8gb"
  
  tags = var.tags
}

module "container_registry" {
  source = "../../modules/container-registry"

  project_name   = var.project_name
  environment    = var.environment
  registry_tier  = var.registry_tier
}

