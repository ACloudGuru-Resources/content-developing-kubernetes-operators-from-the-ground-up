#!/bin/bash

### Install Docker ###
yum -y install docker
usermod -a -G docker cloud_user
su - cloud_user -c 'newgrp docker'
systemctl enable docker.service
systemctl start docker.service

sleep 3

### Install GO ###
wget https://go.dev/dl/go1.21.0.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.21.0.linux-amd64.tar.gz
chmod +x /usr/local/go
su - cloud_user -c 'export PATH=$PATH:/usr/local/go/bin'

### Install kubectl ###
curl -o kubectl https://s3.us-west-2.amazonaws.com/amazon-eks/1.23.7/2022-06-29/bin/linux/amd64/kubectl
chmod +x kubectl
mv kubectl /usr/local/bin/

sleep 3

### Install the Kubernetes Operator SDK ###
export ARCH=$(case $(uname -m) in x86_64) echo -n amd64 ;; aarch64) echo -n arm64 ;; *) echo -n $(uname -m) ;; esac)
export OS=$(uname | awk '{print tolower($0)}')
export OPERATOR_SDK_DL_URL=https://github.com/operator-framework/operator-sdk/releases/download/v1.30.0
curl -LO ${OPERATOR_SDK_DL_URL}/operator-sdk_${OS}_${ARCH}
chmod +x operator-sdk_${OS}_${ARCH} && sudo mv operator-sdk_${OS}_${ARCH} /usr/local/bin/operator-sdk

sleep 3

### Install kind ###
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.16.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

### Start kind Cluster and change context ###
su - cloud_user -c 'kind create cluster --name operator-dev'
su - cloud_user -c 'kubectl cluster-info --context kind-operator-dev'
