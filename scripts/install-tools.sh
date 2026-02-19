#!/bin/bash
# Install required tools for the platform

set -e

echo "Installing required tools..."

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install kubectl
if ! command -v kubectl &> /dev/null; then
    echo "Installing kubectl..."
    brew install kubectl
else
    echo "kubectl already installed"
fi

# Install doctl
if ! command -v doctl &> /dev/null; then
    echo "Installing doctl..."
    brew install doctl
else
    echo "doctl already installed"
fi

# Install Helm
if ! command -v helm &> /dev/null; then
    echo "Installing Helm..."
    brew install helm
else
    echo "Helm already installed"
fi

# Verify installations
echo ""
echo "Verifying installations..."
kubectl version --client
doctl version
helm version

echo ""
echo "All tools installed successfully!"

