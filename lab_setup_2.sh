#!/bin/bash

### Create the Operator project ###
mkdir -p $HOME/projects/memcached-operator
cd $HOME/projects/memcached-operator
operator-sdk init --domain example.com --repo github.com/example/memcached-operator

sleep 5

### Create the API and Controller ###
operator-sdk create api --group cache --version v1alpha1 --kind Memcached --resource --controller

sleep 5

### Add memcached_types.go file ###
wget https://raw.githubusercontent.com/ACloudGuru/content-developing-kubernetes-operators-from-the-ground-up/main/memcached_types.go
mv memcached_types.go api/v1alpha1/

sleep 5

make generate

sleep 3

## Generate CRD Manifests ###
make manifests