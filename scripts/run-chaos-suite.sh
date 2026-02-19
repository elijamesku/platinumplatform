#!/bin/bash
# Run Chaos Engineering Test Suite

set -e

NAMESPACE="chaos-testing"
EXPERIMENTS_DIR="kubernetes/chaos/experiments"

echo "========================================="
echo "Chaos Engineering Test Suite"
echo "========================================="
echo ""

# Check if Chaos Mesh is installed
if ! kubectl get namespace "$NAMESPACE" &> /dev/null; then
  echo "Error: Chaos Mesh namespace not found. Please install Chaos Mesh first."
  echo "Run: helm install chaos-mesh chaos-mesh/chaos-mesh --namespace=$NAMESPACE --create-namespace"
  exit 1
fi

# List of experiments to run
EXPERIMENTS=(
  "pod-kill.yaml"
  "network-partition.yaml"
  "latency-injection.yaml"
)

echo "Running chaos experiments..."
echo ""

for exp in "${EXPERIMENTS[@]}"; do
  if [ ! -f "$EXPERIMENTS_DIR/$exp" ]; then
    echo "Warning: Experiment file $exp not found, skipping..."
    continue
  fi
  
  echo "----------------------------------------"
  echo "Running: $exp"
  echo "----------------------------------------"
  
  # Apply experiment
  kubectl apply -f "$EXPERIMENTS_DIR/$exp"
  
  # Wait for experiment to run
  echo "Waiting 5 minutes for experiment to complete..."
  sleep 300
  
  # Get experiment status
  echo "Experiment status:"
  kubectl get chaos -n "$NAMESPACE" || true
  
  # Cleanup
  echo "Cleaning up experiment..."
  kubectl delete -f "$EXPERIMENTS_DIR/$exp" || true
  
  # Cooldown period
  echo "Cooldown period: 1 minute..."
  sleep 60
  
  echo ""
done

echo "========================================="
echo "Chaos test suite complete!"
echo "========================================="
echo ""
echo "Review results:"
echo "  kubectl get chaos -n $NAMESPACE"
echo "  kubectl get pods --all-namespaces"
echo "  kubectl logs -n monitoring -l app=prometheus"
echo ""

