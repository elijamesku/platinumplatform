output "vpc_id" {
  description = "ID of the primary VPC"
  value       = module.vpc.vpc_id
}

output "cluster_id" {
  description = "ID of the Kubernetes cluster"
  value       = module.kubernetes.cluster_id
}

output "cluster_name" {
  description = "Name of the Kubernetes cluster"
  value       = module.kubernetes.cluster_name
}

output "cluster_endpoint" {
  description = "Endpoint of the Kubernetes cluster"
  value       = module.kubernetes.cluster_endpoint
}

output "registry_endpoint" {
  description = "Endpoint of the container registry"
  value       = module.container_registry.registry_endpoint
}

output "kubeconfig_instructions" {
  description = "Instructions to configure kubectl"
  value       = "Run: doctl kubernetes cluster kubeconfig save ${module.kubernetes.cluster_name}"
}

