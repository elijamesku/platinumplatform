#!/bin/bash
# Full Cluster Recovery Script

set -e

# Configuration
ENVIRONMENT="${ENVIRONMENT:-dev}"
TERRAFORM_DIR="terraform/environments/$ENVIRONMENT"

echo "========================================="
echo "Full Cluster Recovery Script"
echo "Environment: $ENVIRONMENT"
echo "========================================="
echo ""

# Check prerequisites
if ! command -v terraform &> /dev/null; then
  echo "Error: terraform is not installed"
  exit 1
fi

if ! command -v doctl &> /dev/null; then
  echo "Error: doctl is not installed"
  exit 1
fi

if ! command -v kubectl &> /dev/null; then
  echo "Error: kubectl is not installed"
  exit 1
fi

# Step 1: Recreate infrastructure
echo "Step 1: Recreating infrastructure with Terraform..."
cd "$TERRAFORM_DIR"

terraform init
terraform plan
read -p "Review the plan above. Continue with apply? (yes/no): " confirm

if [ "$confirm" != "yes" ]; then
  echo "Recovery cancelled"
  exit 0
fi

terraform apply -auto-approve

# Step 2: Get cluster name and configure kubectl
echo ""
echo "Step 2: Configuring kubectl..."
CLUSTER_NAME=$(terraform output -raw cluster_name)
doctl kubernetes cluster kubeconfig save "$CLUSTER_NAME"

# Verify connection
kubectl cluster-info

# Step 3: Deploy base resources
echo ""
echo "Step 3: Deploying base Kubernetes resources..."
cd ../../..
kubectl apply -f kubernetes/base/namespaces.yaml
kubectl apply -f kubernetes/base/rbac.yaml
kubectl apply -f kubernetes/base/network-policies.yaml
kubectl apply -f kubernetes/base/resource-quotas.yaml

# Step 4: Deploy Argo CD
echo ""
echo "Step 4: Deploying Argo CD..."
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo "Waiting for Argo CD to be ready..."
kubectl wait --for=condition=available --timeout=300s deployment/argocd-server -n argocd || true
kubectl wait --for=condition=available --timeout=300s deployment/argocd-repo-server -n argocd || true
kubectl wait --for=condition=available --timeout=300s deployment/argocd-application-controller -n argocd || true

# Step 5: Get Argo CD admin password
echo ""
echo "Step 5: Argo CD deployment complete!"
echo ""
echo "Initial admin password:"
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" 2>/dev/null | base64 -d || echo "Password not available yet. Wait a few minutes and run:"
echo ""
echo "  kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d"
echo ""

# Step 6: Deploy Argo CD applications
echo "Step 6: Deploying Argo CD applications..."
kubectl apply -f kubernetes/argocd/argocd-apps.yaml || echo "Note: Update repository URL in argocd-apps.yaml"

# Step 7: Status summary
echo ""
echo "========================================="
echo "Recovery Complete!"
echo "========================================="
echo ""
echo "Cluster Name: $CLUSTER_NAME"
echo "Cluster Endpoint: $(terraform -chdir="$TERRAFORM_DIR" output -raw cluster_endpoint)"
echo ""
echo "Next steps:"
echo "1. Access Argo CD UI: kubectl port-forward svc/argocd-server -n argocd 8080:443"
echo "2. Sync applications in Argo CD"
echo "3. Restore database from backup if needed: ./scripts/restore.sh"
echo "4. Verify all services are running: kubectl get pods --all-namespaces"
echo ""

