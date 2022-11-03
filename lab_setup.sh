#!/bin/bash

### Create the Operator project ###
mkdir -p $HOME/projects/memcached-operator
cd $HOME/projects/memcached-operator
operator-sdk init --domain example.com --repo github.com/example/memcached-operator
