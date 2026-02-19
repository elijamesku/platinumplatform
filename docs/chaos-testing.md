# Chaos Testing

## Overview

Chaos Mesh is used to inject failures and validate system resilience.

## Installation

```bash
helm repo add chaos-mesh https://charts.chaos-mesh.org
helm install chaos-mesh chaos-mesh/chaos-mesh \
  --namespace=chaos-testing \
  --create-namespace \
  --set dashboard.create=true
```

## Experiments

### Pod Kill
Validates automatic pod restart and service availability.

```bash
kubectl apply -f kubernetes/chaos/experiments/pod-kill.yaml
```

### Network Partition
Tests service behavior during network failures.

```bash
kubectl apply -f kubernetes/chaos/experiments/network-partition.yaml
```

### Latency Injection
Tests how services handle slow dependencies.

```bash
kubectl apply -f kubernetes/chaos/experiments/latency-injection.yaml
```

## Monitoring

During experiments, monitor:
- Request latency
- Error rate
- Pod restart count
- CPU/Memory usage
- Database connection pool

## Success Criteria

- System automatically recovers
- No data loss
- Recovery time < RTO
- No manual intervention required
- Metrics return to baseline

## Automated Testing

Run the chaos test suite:

```bash
./scripts/run-chaos-suite.sh
```
