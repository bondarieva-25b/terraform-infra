#!/bin/bash
set -o xtrace

mkdir -p /etc/nodeadm

cat <<EOF > /etc/nodeadm/node-config.yaml
---
apiVersion: node.eks.aws/v1alpha1
kind: NodeConfig
spec:
  cluster:
    name: ${cluster_name}
    apiServerEndpoint: ${cluster_endpoint}
    certificateAuthority: ${cluster_ca}
    cidr: ${cluster_service_cidr}
  kubelet:
    flags:
      - --node-labels=node.kubernetes.io/lifecycle=$(curl -s http://169.254.169.254/latest/meta-data/instance-life-cycle)
EOF

nodeadm init --config-source file:///etc/nodeadm/node-config.yaml
