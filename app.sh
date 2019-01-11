#! /usr/bin/env bash

# Create a project for the application
oc new-project book-info

# Add privileged permissions to run the Envoy proxy sidecarc container
oc adm policy add-scc-to-user privileged -z default -n book-info

# Deploy the application
oc apply -f <(istioctl kube-inject -f samples/bookinfo/platform/kube/bookinfo.yaml) -n book-info