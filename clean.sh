#!/bin/bash

kubectl delete --all deployment
kubectl delete --all services
kubectl delete --all secret
kubectl delete --all configmap
kubectl delete --all pv,pvc
kubectl delete --all pod
docker rmi -f $(docker images -q)
minikube delete
rm -rf ~/.minikube
