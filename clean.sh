#!/bin/bash

kubectl delete --all deployment
kubectl delete --all services
kubectl delete --all secret
kubectl delete --all configmap
kubectl delete --all pv,pvc
kubectl delete --all pod
minikube delete
docker rmi $(docker images -q)
