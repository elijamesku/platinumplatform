# Disaster Recovery

## Recovery Objectives

- RTO: 15 minutes
- RPO: 24 hours

## Backup Strategy

### Infrastructure
- Terraform state in remote backend (DigitalOcean Spaces)
- All Kubernetes manifests in Git
- Version controlled with tags

### Application Data
- PostgreSQL: Daily automated backups via DigitalOcean managed database
- Redis: Daily snapshots
- Persistent volumes: Daily snapshots

## Recovery Procedures

### Complete Cluster Failure

1. Verify infrastructure state: `terraform state list`
2. Recreate cluster: `terraform apply`
3. Configure kubectl: `doctl kubernetes cluster kubeconfig save <cluster-name>`
4. Deploy base resources: `kubectl apply -f kubernetes/base/`
5. Deploy Argo CD: `kubectl apply -f kubernetes/argocd/`
6. Sync applications via Argo CD
7. Restore database from backup

### Database Corruption

1. Identify last good backup: `doctl databases backup list <database-id>`
2. Restore: `doctl databases restore <database-id> --backup-id <backup-id>`
3. Verify data integrity
4. Restart applications: `kubectl rollout restart deployment -n <namespace>`

### Region Failure

1. Failover to secondary region
2. Update DNS/load balancer configuration
3. Restore from backups in secondary region
4. Verify services

## Automated Recovery

Use `scripts/full-recovery.sh` for automated cluster recovery.

## Testing

- Monthly DR drills: Destroy test cluster, measure recovery time
- Quarterly full DR test: Simulate region failure, test failover
- Chaos engineering: Use Chaos Mesh to simulate failures
