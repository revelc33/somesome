# We will asume the system has docker , git 

echo "Stoping previous containers"

# finding id container to stop it
container_id=$(docker ps -q --filter "ancestor=maquema/backend:hoy")

sudo docker stop $container_id 2>/dev/null

# finding id container to stop it

container_id=$(docker ps -q --filter "ancestor=maquema/frontend:hoy")

sudo docker stop $container_id 2>/dev/null

cd ../frontend

echo "Building  Docker frontend image"

# building frontend docker image
sudo docker build -t maquema/frontend:hoy .

sudo docker run -p81:8000 -e BACKEND_DOMAIN=localhost -t maquema/frontend:hoy &


echo "Building  Docker backend image"
cd ../backend
sudo docker build -t maquema/backend:hoy .
sudo docker run -p80:5001 -e SERVICE_CLOCK_PORT=5001 -t maquema/backend:hoy &

echo "************************************************"
echo "Open Browser on http://127.0.0.1:81 for testing."
echo "************************************************"

browse http://127.0.0.1:81
