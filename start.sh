#!/bin/bash

if ! which docker >/dev/null 2>&1 ||
    ! which minikube >/dev/null 2>&1
then
    echo Please install Docker and Minikube
    exit 1
fi

uname=`uname -s`

status=`minikube status | grep "host" | sed "s/host: //g" | tr -d "\n"`
if [[ $status == "Stopped" || $status == "" ]]
then
	if [[ $uname == "Darwin"* ]]; then
		minikube start --driver=virtualbox --cpus=4 --memory=4G
	elif [[ $uname == "Linux"* ]]; then
		minikube start --driver=docker
	fi
	minikube -p minikube docker-env
	eval $(minikube -p minikube docker-env)
fi

if [[ $uname == "Linux"* ]]; then
	IP=`minikube ip | rev | cut -c3- | rev`
	sed -i "s/value: .*\.50/value: $IP.50/g" ./nginx-deployment.yaml
	sed -i "s/PMA_IP=.*$/PMA_IP=$IP.50/g" ./phpmyadmin-deployment.yaml
	sed -i "s/loadBalancerIP: .*$/loadBalancerIP: $IP.50/g" ./*-deployment.yaml
	sed -i "12s/- .*$/- $IP.50-$IP.50/g" ./metallb/metallb-config.yaml
	sed -i "s/192.168.99.50/$IP.50/g" ./mysql/wordpress.sql
	sed -i "s/pasv_address=.*$/pasv_address=$IP.50/g" ./ftps/vsftpd.conf
elif [[ $uname == "Darwin"* ]]; then
	IP=`minikube ip | rev | cut -c5- | rev`
	sed -i "" "s/value: .*\.50/value: $IP.50/g" ./nginx-deployment.yaml
	sed -i "" "s/PMA_IP=.*$/PMA_IP=$IP.50/g" ./phpmyadmin-deployment.yaml
	sed -i "" "s/loadBalancerIP: .*$/loadBalancerIP: $IP.50/g" ./*-deployment.yaml
	sed -i "" "12s/- .*$/- $IP.50-$IP.50/g" ./metallb/metallb-config.yaml
	sed -i "" "s/192.168.99.50/$IP.50/g" ./mysql/wordpress.sql
	sed -i "" "s/pasv_address=.*$/pasv_address=$IP.50/g" ./ftps/vsftpd.conf
fi

echo "metallb"
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl diff -f - -n kube-system
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl apply -f - -n kube-system
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.4/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.4/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl apply -f metallb/metallb-config.yaml

eval $(minikube docker-env)

#minikube addons enable metallb
minikube ip
minikube dashboard &

kubectl create configmap grafana-dashboards --from-file=grafana/dashboards/
kubectl create configmap ftps-config --from-file=ftps/vsftpd.conf
kubectl apply -f influxdb/influxdb-config.yaml

echo -e "\033[47m\033[32m influxdb image build \033[m"
docker build -t influxdb:42 influxdb/
echo -e "\033[47m\033[32m influxdb deployment \033[m"
kubectl apply -f influxdb-deployment.yaml

echo -e "\033[47m\033[32m mysql image build \033[m"
docker build -t mysql:42 mysql/
echo -e "\033[47m\033[32m mysql deployment \033[m"
kubectl apply -f mysql-deployment.yaml

echo -e "\033[47m\033[32m wordpress image build \033[m"
docker build -t wordpress:42 wordpress/
echo -e "\033[47m\033[32m wordpress deployment \033[m"
kubectl apply -f wordpress-deployment.yaml

echo -e "\033[47m\033[32m phpmyadmin image build \033[m"
docker build -t phpmyadmin:42 phpmyadmin/
echo -e "\033[47m\033[32m phpmyadmin deployment \033[m"
kubectl apply -f phpmyadmin-deployment.yaml

echo -e "\033[47m\033[32m ftps image build \033[m"
docker build -t ftps:42 ftps/
echo -e "\033[47m\033[32m ftps deployment \033[m"
kubectl apply -f ftps-deployment.yaml

echo -e "\033[47m\033[32m nginx image build \033[m"
docker build -t nginx:42 nginx/
echo -e "\033[47m\033[32m nginx deployment \033[m"
kubectl apply -f nginx-deployment.yaml

echo -e "\033[47m\033[32m grafana image build \033[m"
docker build -t grafana:42 grafana/
echo -e "\033[47m\033[32m grafana deployment \033[m"
kubectl apply -f grafana-deployment.yaml
