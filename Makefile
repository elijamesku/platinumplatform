.PHONY: help terraform-init terraform-plan terraform-apply terraform-destroy k8s-setup argocd-install vault-install observability-install chaos-install backup restore

help: ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Available targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  %-20s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

terraform-init: ## Initialize Terraform
	cd terraform/environments/dev && terraform init

terraform-plan: ## Run Terraform plan
	cd terraform/environments/dev && terraform plan

terraform-apply: ## Apply Terraform changes
	cd terraform/environments/dev && terraform apply

terraform-destroy: ## Destroy Terraform infrastructure
	cd terraform/environments/dev && terraform destroy

k8s-setup: ## Set up Kubernetes base resources
	kubectl apply -f kubernetes/base/

argocd-install: ## Install Argo CD
	./kubernetes/argocd/install.sh

vault-install: ## Install HashiCorp Vault
	./kubernetes/vault/install.sh

observability-install: ## Install observability stack
	kubectl apply -f kubernetes/observability/

chaos-install: ## Install Chaos Mesh
	helm repo add chaos-mesh https://charts.chaos-mesh.org
	helm repo update
	helm install chaos-mesh chaos-mesh/chaos-mesh --namespace=chaos-testing --create-namespace

backup: ## Run database backup
	./scripts/backup.sh

restore: ## Restore database from backup
	@echo "Usage: DATABASE_ID=xxx BACKUP_ID=yyy make restore"
	./scripts/restore.sh

recover: ## Full cluster recovery
	./scripts/full-recovery.sh

chaos-test: ## Run chaos engineering test suite
	./scripts/run-chaos-suite.sh

