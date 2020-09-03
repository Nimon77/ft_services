#!/bin/bash

if ! which docker >/dev/null 2>&1 ||
    ! which minikube >/dev/null 2>&1
then
    echo Please install Docker and Minikube
    exit 1
fi

status=`minikube status | grep "host" | sed "s/host: //g" | tr -d "\n"`
if [[ $status == "Stopped" || $status == "" ]]
then
	minikube start --driver=virtualbox
	minikube -p minikube docker-env
	eval $(minikube -p minikube docker-env)
fi

echo "metallb"
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl diff -f - -n kube-system
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl apply -f - -n kube-system
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl apply -f metallb/metallb-config.yaml

#eval $(minikube docker-env)

#minikube addons enable metallb
minikube ip

echo -e "\033[47m\033[32m nginx image build \033[m"
docker build -t nginx:42 nginx/ > /dev/null
#docker build -t grafana:42 grafana/
#docker build -t wordpress:42 wordpress/

echo -e "\033[47m\033[32m nginx deployment 생성 \033[m"
kubectl apply -f nginx-deployment.yaml
#kubectl apply -f grafana-deployment.yaml
#kubectl apply -f wordpress-deployment.yaml
