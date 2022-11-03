#!/bin/bash

### Create the Operator project ###
mkdir -p $HOME/projects/memcached-operator
cd $HOME/projects/memcached-operator
operator-sdk init --domain example.com --repo github.com/example/memcached-operator

sleep 5

### Create the API and Controller ###
operator-sdk create api --group cache --version v1alpha1 --kind Memcached --resource --controller

### Add memcached_types.go file ###
wget 
mv memcached_types.go api/v1alpha1/
make generate

### Generate CRD Manifests ###
make manifests

### Add memcached_controller.go file ###
wget 
mv memcached_controller_2.go controllers/memcached_controller.go

### Generate RBAC Manifests ###
make manifests