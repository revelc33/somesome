## Infra/DevOps Test

The original exercise was proposed with Ansible. However, I suggested doing it with Kubernetes/Docker.

To facilitate testing, I also added the option to deploy it locally using Docker, but both options are available:
- Docker run
- Kubernetes manifests

To deploy the solution, you just need to execute a single command (in a Linux environment with Docker or Kubernetes available).

### Deploying in a single command line

```bash
git clone https://github.com/revelc33/somesome.git && cd somesome/scripts && bash launcher.sh
```

#### Details
The main deployment file is a script (`launcher.sh`) that initiates a menu that basically calls one of the chosen deployment options:

- Docker (`dockerDeploy/main.sh`):
  - This option requires Docker to be installed locally, and the user must have permissions to run Docker. Of course, the Docker service must also be running.
- Kubernetes (`kubernetesDeploy/main.sh`):
  - This option requires `kubectl` and `envsubst` to be installed.

### Manual Deployment

If you prefer to deploy manually, you can follow these steps:

#### Docker Local

```bash
git clone https://github.com/revelc33/somesome.git && cd somesome
```

##### Building/Deploying the frontend service

```bash
cd frontend
sudo docker build -t maquema/frontend:hoy .
sudo docker run -p 81:8000 -e BACKEND_DOMAIN=localhost -t maquema/frontend:hoy &
```

##### Building/Deploying the backend service

```bash
cd ../backend
sudo docker build -t maquema/backend:hoy .
sudo docker run -p 80:5001 -e SERVICE_CLOCK_PORT=5001 -t maquema/backend:hoy &
```

To test the application, open your browser and enter [http://127.0.0.1:81](http://127.0.0.1:81)

(The goal of this test is to deploy a simple "clock" web application (frontend + backend) in a container machine using Docker.)

### Assets 

|-- backend/        (Clock service sources (Python/Flask), Dockerfile, and Kubernetes manifests.)
|   |-- src/
|   |   |-- [backend service source code]
|   |-- Dockerfile
|   |-- backend.yaml (Kubernetes manifest)
|
|-- frontend/       (Frontend sources , Dockerfile, and Kubernetes manifests.)
|   |-- src/
|   |   |-- [frontend service source code]
|   |-- Dockerfile
|   |-- frontend.yaml (Kubernetes manifest)
|
|-- scripts/        (Script for deploying locally in Docker with Docker run.)
|   |-- build-docker-and-deploy.sh (script to build Docker image and deploy locally)
|   |-- deploy-kubernetes.sh (script to deploy in Kubernetes)
|   |-- launcher.sh  (The main script for full deployment.)
|
|-- README.md (project documentation)



`Kubernetes Deployment (requires 'kubectl' pointing to the correct Kubernetes cluster and envsubst tool instlled) (tested in EKS and Minikube).`


## Extra points

- Run frontend and backend services using Docker **(DONE)**
- Configure the backend application using environment variables **(DONE)**
- Don't run services as root **(DONE)**
- Configure and deploy **EVERYTHING** using a single command, i.e., a bash script **(DONE)**