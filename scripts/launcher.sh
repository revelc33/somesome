#!/bin/bash

# Establecer el tiempo de espera en segundos
timeout=5

docker_local(){
	clear
	echo "Deploying locally using Docker."
	bash build-docker-and-deploy.sh
}


kubernetes(){
	clear
	echo "Deploying on Kubernetes."
	bash deploy-kubernetes.sh
}

choosedeploy(){
	clear
	#while true
	#do
	# Parent menu items declared here
	select item in "Deploying locally using Docker" "Deploying on Kubernetes"
	do
	# case statement to compare 
	case $item in
	"Deploying on Kubernetes")
	kubernetes
	break
	;;
	"Deploying locally using Docker")
	docker_local
	break
	esac
	#done
	done
}

# Mostrar el mensaje de solicitud
echo "Press any key if you want customized deployment. By default will be deployed locally with Docker Run : (timeout in $timeout seconds):"

# Leer la entrada con timeout
read -t $timeout

# Verificar si se proporcionó una entrada

if [ -z "$REPLY" ]; then
  choosedeploy
else
  docker_local
fi

