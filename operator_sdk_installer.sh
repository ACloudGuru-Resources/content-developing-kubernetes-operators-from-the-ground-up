#!/bin/bash

### Install the Kubernetes Operator SDK ###
export ARCH=$(case $(uname -m) in x86_64) echo -n amd64 ;; aarch64) echo -n arm64 ;; *) echo -n $(uname -m) ;; esac)
export OS=$(uname | awk '{print tolower($0)}')
export OPERATOR_SDK_DL_URL=https://github.com/operator-framework/operator-sdk/releases/download/v1.11.0
curl -LO ${OPERATOR_SDK_DL_URL}/operator-sdk_${OS}_${ARCH}
chmod +x operator-sdk_${OS}_${ARCH} && sudo mv operator-sdk_${OS}_${ARCH} /usr/local/bin/operator-sdk

sleep 3

### Install kind ###
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.14.0/kind-linux-amd64
chmod +x ./kind && sudo mv ./kind /usr/local/bin/kind

sleep 3

### Start kind cluster ###
systemctl start docker
sleep 5
sudo systemctl enable docker
su -c 'usermod -aG docker $USER'
su -c 'newgrp docker'
su -c 'kind create cluster --name guru-test-cluster'