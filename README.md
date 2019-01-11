# Istio Demo

Simple demonstration (and compilation of data) using Istio in OpenShift.

The resources were gathered from the [Istio](http://istio.io) and [Kiali](http://kiali.io) sites.

## Deploy in MiniShift

    minishift start

    sh scripts/istio.sh

## Deploy Book Info sample application

This application is provided by Istio and can be found [here](http://istio.io/docs/examples/bookinfo).

    sh scripts/app.sh

## Examples

A list of useful examples can be found [here](http://istio.io/docs/examples/intelligent-routing).

