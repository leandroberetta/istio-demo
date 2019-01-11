#! /usr/bin/env bash

# The following steps are from istio.io and kiali.io documentation

# Istio

# Get the latest Istio release
curl -L https://git.io/getLatestIstio | sh -

# Get into the istio folder
cd istio-1.0.5

# Add the binaries to the path
export PATH=$PWD/bin:$PATH

# Create the custom resource definitions that Istio use
oc apply -f install/kubernetes/helm/istio/templates/crds.yaml

# Deploy Istio (in istio-system project)
oc apply -f install/kubernetes/istio-demo.yaml

# Check the services
oc get svc -n istio-system

# Check the pods
oc get pods -n istio-system

# OpenShift doesn’t allow containers running with user id 0, it  must be enabled
oc adm policy add-scc-to-user anyuid -z istio-ingress-service-account -n istio-system
oc adm policy add-scc-to-user anyuid -z default -n istio-system
oc adm policy add-scc-to-user anyuid -z prometheus -n istio-system
oc adm policy add-scc-to-user anyuid -z istio-egressgateway-service-account -n istio-system
oc adm policy add-scc-to-user anyuid -z istio-citadel-service-account -n istio-system
oc adm policy add-scc-to-user anyuid -z istio-ingressgateway-service-account -n istio-system
oc adm policy add-scc-to-user anyuid -z istio-cleanup-old-ca-service-account -n istio-system
oc adm policy add-scc-to-user anyuid -z istio-mixer-post-install-account -n istio-system
oc adm policy add-scc-to-user anyuid -z istio-mixer-service-account -n istio-system
oc adm policy add-scc-to-user anyuid -z istio-pilot-service-account -n istio-system
oc adm policy add-scc-to-user anyuid -z istio-sidecar-injector-service-account -n istio-system
oc adm policy add-scc-to-user anyuid -z istio-galley-service-account -n istio-system

# Kiali

export GRAFANA_URL=http://$(oc get route grafana -n istio-system -o template --template='{{.spec.host}}')
export JAEGER_URL=http://$(oc get route tracing -n istio-system -o template --template='{{.spec.host}}')

curl -L http://git.io/getLatestKiali | bash

# The application to test is the book info from istio.io

# Create a project for the application
oc new-project book-info

# Add privileged permissions to run the Envoy proxy sidecarc container
oc adm policy add-scc-to-user privileged -z default -n book-info

# Deploy the application
oc apply -f <(istioctl kube-inject -f samples/bookinfo/platform/kube/bookinfo.yaml) -n book-info