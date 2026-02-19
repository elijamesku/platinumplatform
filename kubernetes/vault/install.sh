#!/bin/bash
# Install HashiCorp Vault

set -e

echo "Installing HashiCorp Vault..."

# Add Helm repository
helm repo add hashicorp https://helm.releases.hashicorp.com
helm repo update

# Create namespace
kubectl create namespace vault --dry-run=client -o yaml | kubectl apply -f -

# Install Vault with HA configuration
helm install vault hashicorp/vault \
  --namespace vault \
  --set "server.ha.enabled=true" \
  --set "server.ha.replicas=3" \
  --set "server.ha.raft.enabled=true" \
  --set "ui.enabled=true" \
  --set "ui.serviceType=LoadBalancer"

# Wait for Vault to be ready
echo "Waiting for Vault to be ready..."
kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=vault -n vault --timeout=300s

echo "Vault installed successfully!"
echo ""
echo "To access Vault UI, get the LoadBalancer IP:"
echo "kubectl get svc vault-ui -n vault"
echo ""
echo "To initialize Vault, run:"
echo "kubectl exec -it vault-0 -n vault -- vault operator init"
echo ""
echo "To unseal Vault, run:"
echo "kubectl exec -it vault-0 -n vault -- vault operator unseal <unseal-key>"

