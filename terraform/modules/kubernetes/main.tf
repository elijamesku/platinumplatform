resource "digitalocean_kubernetes_cluster" "main" {
  name    = "${var.cluster_name}-${var.environment}"
  region  = var.region
  version = var.kubernetes_version
  vpc_uuid = var.vpc_id

  node_pool {
    name       = "system-pool"
    size       = var.system_node_size
    node_count = var.system_node_count
    auto_scale = false
    tags       = concat(var.tags, ["system", "critical"])
  }

  node_pool {
    name       = "app-pool"
    size       = var.app_node_size
    node_count = var.app_node_count
    auto_scale = var.enable_auto_scaling
    min_nodes  = var.enable_auto_scaling ? var.min_nodes : null
    max_nodes  = var.enable_auto_scaling ? var.max_nodes : null
    tags       = concat(var.tags, ["app", "autoscaling"])
  }

  node_pool {
    name       = "worker-pool"
    size       = var.worker_node_size
    node_count = var.worker_node_count
    auto_scale = var.enable_auto_scaling
    min_nodes  = var.enable_auto_scaling ? var.min_worker_nodes : null
    max_nodes  = var.enable_auto_scaling ? var.max_worker_nodes : null
    tags       = concat(var.tags, ["worker", "background-jobs"])
  }

  maintenance_policy {
    day        = "sunday"
    start_time = "02:00"
  }

  auto_upgrade = true
}

