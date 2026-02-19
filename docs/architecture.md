# Architecture

## Overview

Multi-region Kubernetes platform on DigitalOcean with GitOps, observability, and chaos engineering.

## Components

### Networking
- Primary VPC in NYC3, secondary in SFO3
- Private subnets for Kubernetes nodes
- Public subnets for load balancers
- Network policies for pod isolation

### Kubernetes
- DigitalOcean Kubernetes (DOKS) managed cluster
- Three node pools: system, app, worker
- Autoscaling enabled on app and worker pools
- Pod security standards (restricted mode)
- Resource quotas per namespace

### GitOps
- Argo CD for declarative deployments
- Applications synced from Git repository
- Multi-environment support via Kustomize

### Secrets Management
- HashiCorp Vault in HA mode (3 replicas)
- Kubernetes authentication
- Dynamic database credentials
- Secret rotation workflows

### Observability
- Prometheus for metrics
- Grafana dashboards
- Loki for log aggregation
- Alertmanager for notifications

### Chaos Engineering
- Chaos Mesh for failure injection
- Pod kill, network partition, latency experiments
- Automated test suite

### CI/CD
- GitHub Actions for Terraform automation
- Docker builds and pushes to DigitalOcean registry
- Kubernetes deployments via Argo CD
- Security scanning with Trivy and Checkov

## Data Flow

```
Internet → Load Balancer → Ingress → Services → Pods → Databases
```

## High Availability

- Multi-AZ node distribution
- Pod disruption budgets
- Health checks (liveness/readiness)
- Horizontal pod autoscaling
- Cluster autoscaling

## Security

- Network policies restrict pod communication
- RBAC with least-privilege
- Pod security standards
- Secrets in Vault, not Git
- TLS for external traffic
- Firewall rules with minimal exposure
