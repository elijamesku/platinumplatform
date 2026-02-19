# Multi-Region Kubernetes Platform

```
                                 ,        ,
                                /(        )`
                                \ \___   / |
                                /- _  `-/  '
                               (/\/ \ \   /\
                               / /   | `    \
                               O O   ) /    |
                               `-^--'`<     '
                   TM         (_.)  _  )   /
|  | |\  | ~|~ \ /             `.___/`    /
|  | | \ |  |   X                `-----' /
`__| |  \| _|_ / \  <----.     __ / __   \
                    <----|====O)))==) \) /====
                    <----'    `--' `.__,' \
                                 |        |
                                  \       /
                             ______( (_  / \______
                           ,'  ,-----'   |        \
                           `--{__________)        \/
```

## Architecture Overview

This platform implements:

- **Multi-Region VPC Architecture** - Two DigitalOcean regions with private networking
- **Kubernetes Clusters** - Managed DOKS with autoscaling node pools
- **GitOps Deployment** - Argo CD for declarative application management
- **Secrets Management** - HashiCorp Vault with dynamic credentials
- **Full Observability** - Prometheus, Grafana, and Loki stack
- **Chaos Engineering** - Chaos Mesh for resilience testing
- **CI/CD Pipelines** - GitHub Actions with Terraform automation
- **Disaster Recovery** - Automated backups and recovery procedures

## Project Structure

```
platinumplatform/
├── terraform/              # Infrastructure as Code
│   ├── modules/           # Reusable Terraform modules
│   │   ├── vpc/           # VPC and networking
│   │   ├── kubernetes/    # Kubernetes cluster
│   │   ├── loadbalancer/  # Load balancer config
│   │   └── firewall/      # Security groups
│   ├── environments/      # Environment-specific configs
│   │   ├── dev/
│   │   └── prod/
│   └── main.tf            # Root module
├── kubernetes/            # Kubernetes manifests
│   ├── base/              # Base resources (namespaces, RBAC)
│   ├── argocd/            # GitOps configuration
│   ├── vault/             # Secrets management
│   ├── observability/     # Monitoring stack
│   ├── chaos/             # Chaos engineering
│   └── apps/              # Application manifests
├── ci-cd/                 # CI/CD pipelines
│   └── .github/
│       └── workflows/
├── scripts/               # Automation scripts
│   ├── backup.sh          # Backup automation
│   └── restore.sh         # Disaster recovery
└── docs/                  # Documentation
    ├── architecture.md
    ├── disaster-recovery.md
    └── chaos-testing.md
```

## Setup

Prerequisites: Terraform >= 1.5.0, kubectl >= 1.28, doctl, DigitalOcean API token

```bash
# Configure DigitalOcean
export DIGITALOCEAN_TOKEN="<token>"
doctl auth init

# Deploy infrastructure
cd terraform/environments/dev
terraform init
terraform plan
terraform apply

# Configure kubectl
doctl kubernetes cluster kubeconfig save <cluster-name>

# Deploy Argo CD
kubectl apply -f kubernetes/argocd/
```

## Key Features

### Infrastructure as Code
- Complete infrastructure defined in Terraform
- Multi-region VPC architecture
- Automated cluster provisioning
- State management with remote backend

### Kubernetes Platform
- Managed DigitalOcean Kubernetes
- Autoscaling node pools
- Network policies for security
- Pod security standards
- Resource quotas and limits

### GitOps with Argo CD
- Declarative application deployment
- Automated sync from Git
- Multi-environment support
- Rollback capabilities

### Secrets Management
- HashiCorp Vault deployment
- Dynamic database credentials
- Policy-based access control
- Secret rotation workflows

### Observability
- Prometheus metrics collection
- Grafana dashboards
- Loki log aggregation
- Alerting rules
- Uptime monitoring

### Chaos Engineering
- Chaos Mesh for failure injection
- Pod kill scenarios
- Network partition testing
- Node failure simulation
- Auto-healing validation

### CI/CD
- GitHub Actions workflows
- Terraform plan/apply automation
- Docker image builds
- Automated deployments
- Security scanning

### Disaster Recovery
- Automated database backups
- Cluster state in Git
- Recovery runbooks
- RTO/RPO documentation

## Monitoring Dashboards

Access Grafana to view:

- **Platform Health** - Cluster metrics, node status, pod distribution
- **Application Metrics** - Request latency, error rates, throughput
- **Resource Utilization** - CPU, memory, network usage
- **Chaos Experiments** - Failure injection results and recovery times

## Security Features

- Private networking between regions
- Network policies restricting pod-to-pod communication
- Pod security standards (restricted mode)
- Secrets stored in Vault (not in Git)
- Least-privilege RBAC
- Firewall rules with minimal exposure
- TLS/SSL for all external traffic

## Chaos Testing

Chaos experiments are defined in `kubernetes/chaos/experiments/`. Run the test suite:

```bash
./scripts/run-chaos-suite.sh
```

## Documentation

- [Architecture](docs/architecture.md)
- [Disaster Recovery](docs/disaster-recovery.md)
- [Chaos Testing](docs/chaos-testing.md)
