output "kubernetes_firewall_id" {
  description = "ID of the Kubernetes firewall"
  value       = digitalocean_firewall.kubernetes.id
}

output "loadbalancer_firewall_id" {
  description = "ID of the load balancer firewall"
  value       = digitalocean_firewall.loadbalancer.id
}

