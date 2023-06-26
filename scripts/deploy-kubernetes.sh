echo "Applying Kubernetes manifests."
RED='\033[0;31m'
NC='\033[0m' # without color

echo "NOTE: "
echo -e "\t - ${RED}kubectl must be pointing to the correct context to deploy the manifests to the corresponding Kubernetes cluster."
echo -e "\t - envsubst must be installed (apt install gettext-base -y)${NC}"

echo "Cleaning kubernetes previous configs"

kubectl delete -f ../backend 2> /dev/null
kubectl delete -f ../frontend 2> /dev/null


echo "Deploying Backend Clock service"

kubectl apply -f ../backend
sleep 10 # waiting loadbalancer service created

echo "Getting backend load balancer Domain to point frontend service"

export BACKEND_DOMAIN=$(kubectl get service backend-lb-ext -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')

if [ -z "$BACKEND_DOMAIN" ]; then
	export BACKEND_DOMAIN=$(kubectl get service backend-lb-ext -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
fi

echo "Deploying Backend service"

envsubst < ../frontend/frontend-deployment.yaml | kubectl apply -f -
kubectl apply -f ../frontend/frontend-service.yaml

sleep 10 # waiting loadbalancer service created

export FRONTEND_DOMAIN=$(kubectl get service frontend-lb -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')

if [ -z "$FRONTEND_DOMAIN" ]; then
	export FRONTEND_DOMAIN=$(kubectl get service frontend-lb -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
fi

echo -e "${RED}Please Open your Browser on http://$FRONTEND_DOMAIN for testing.${NC}"
browse http://$FRONTEND_DOMAIN


