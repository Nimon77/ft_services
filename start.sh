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
	minikube start --driver=virtualbox --cpus=8 --memory=8G
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

eval $(minikube docker-env)

#minikube addons enable metallb
minikube ip

echo -e "\033[47m\033[32m nginx image build \033[m"
docker build -t nginx:42 nginx/
echo -e "\033[47m\033[32m influxdb image build \033[m"
docker build -t influxdb:42 influxdb/
echo -e "\033[47m\033[32m grafana image build \033[m"
docker build -t grafana:42 grafana/
echo -e "\033[47m\033[32m wordpress image build \033[m"
docker build -t wordpress:42 wordpress/
echo -e "\033[47m\033[32m mysql image build \033[m"
docker build -t mysql:42 mysql/
echo -e "\033[47m\033[32m phpmyadmin image build \033[m"
docker build -t phpmyadmin:42 phpmyadmin/

kubectl create configmap default-nginx-config --from-file=nginx/website.conf

echo -e "\033[47m\033[32m nginx deployment \033[m"
kubectl apply -f nginx-deployment.yaml
echo -e "\033[47m\033[32m influxdb deployment \033[m"
kubectl apply -f influxdb-deployment.yaml
echo -e "\033[47m\033[32m grafana deployment \033[m"
kubectl apply -f grafana-deployment.yaml
echo -e "\033[47m\033[32m wordpress deployment \033[m"
kubectl apply -f wordpress-deployment.yaml
echo -e "\033[47m\033[32m mysql deployment \033[m"
kubectl apply -f mysql-deployment.yaml
echo -e "\033[47m\033[32m phpmyadmin deployment \033[m"
kubectl apply -f phpmyadmin-deployment.yaml
