# lua based-OpenResty App on KIND with Ingress
how to build a Docker image for an OpenResty app, deploy it on a local Kubernetes cluster using KIND, and expose it via NGINX Ingress.


---

## 🐳 Step 1: Build Docker Image

```bash
docker build -t openresty-hello:v1 .
Replace . with the correct context directory if your Dockerfile is in a subfolder.

⚙️ Step 2: Install KIND
Follow the official KIND installation guide.
https://kind.sigs.k8s.io/docs/user/quick-start/#installation

⛴️ Step 3: Create KIND Cluster with Port Mapping
Create a kind-cluster.yaml file with the following content:

kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
  - role: control-plane
    extraPortMappings:
      - containerPort: 80
        hostPort: 80
        protocol: TCP
      - containerPort: 443
        hostPort: 443
        protocol: TCP
      - containerPort: 30080
        hostPort: 30080
        protocol: TCP

Now create the cluster:

bash
kind create cluster --name <cluster-name> --config kind-cluster.yaml

It maps container ports to your host to expose services like HTTP (80), HTTPS (443), or custom ports like 30080.

🧭 Step 4: Set the New KIND Cluster as Current Context
bash
kubectl config use-context <culster-name>

To confitm:
kubectl config current-context

🌐 Step 5: Install NGINX Ingress Controller
bash
kubectl apply -f https://kind.sigs.k8s.io/examples/ingress/deploy-ingress-nginx.yaml
This installs the NGINX ingress controller required to route traffic to your services.

📦 Step 6: Load Docker Image into KIND
bash
Copy
Edit
kind load docker-image openresty-hello:v1 --name <cluster-name>
🚀 Step 7: Apply Kubernetes Manifests
bash
Copy
Edit
kubectl apply -f deployment.yaml
📝 Step 8: Edit /etc/hosts File
Add the following entry to your system’s /etc/hosts file:

lua
Copy
Edit
127.0.0.1 openresty.local
✅ Step 9: Test the Application
bash
Copy
Edit
curl http://openresty.local/hello
Expected output:

csharp
Copy
Edit
Hello from sandhra!
🧹 Cleanup 
To delete the cluster:

bash
Copy
Edit
kind delete cluster --name <cluster-name>
go
Copy
Edit







You said:
please write me a proper readme,md file for github


ChatGPT said:
Here’s a complete and well-structured README.md for your GitHub repository that describes the OpenResty + KIND + Ingress setup:

markdown
Copy
Edit
# 🚀 OpenResty with KIND & Ingress

This project demonstrates how to build and deploy an OpenResty Lua application inside a local Kubernetes cluster using [KIND (Kubernetes IN Docker)](https://kind.sigs.k8s.io/), expose it with an NGINX Ingress controller, and test it via custom hostname routing.

---

## 📦 Features

- 🔧 Dockerized OpenResty app using Lua.
- 🐳 Deployed to a local KIND cluster.
- 🌐 Exposed with NGINX Ingress using custom domain.
- ✅ Testable via simple curl requests.

---

## 📁 Directory Structure

.
├── app/
│ ├── nginx.conf # NGINX + Lua configuration
│ └── hello.lua # Lua module with handler functions
├── Dockerfile # Dockerfile to build OpenResty image
├── deployment.yaml # Kubernetes Deployment
├── service.yaml # Kubernetes Service
├── ingress.yaml # Kubernetes Ingress
├── kind-cluster.yaml # KIND cluster configuration
└── README.md # You are here

yaml
Copy
Edit

---

## 🧱 Prerequisites

- Docker
- kubectl
- KIND
- curl
- sudo/root access to edit `/etc/hosts`

---

## 🔨 Step-by-Step Guide

### 1. Build the Docker Image

```bash
docker build -t openresty-hello:v1 .
2. Create a KIND Cluster
Create the kind-cluster.yaml:

yaml
Copy
Edit
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
  - role: control-plane
    extraPortMappings:
      - containerPort: 80
        hostPort: 80
        protocol: TCP
      - containerPort: 443
        hostPort: 443
        protocol: TCP
      - containerPort: 30080
        hostPort: 30080
        protocol: TCP
Create the cluster:

bash
Copy
Edit
kind create cluster --name prophaze --config kind-cluster.yaml
3. Use the New Context
bash
Copy
Edit
kubectl config use-context kind-prophaze
4. Install NGINX Ingress Controller
bash
Copy
Edit
kubectl apply -f https://kind.sigs.k8s.io/examples/ingress/deploy-ingress-nginx.yaml
Wait a minute for the ingress controller pods to be ready:

bash
Copy
Edit
kubectl get pods -n ingress-nginx
5. Load Docker Image into KIND
bash
Copy
Edit
kind load docker-image openresty-hello:v1 --name prophaze
6. Deploy the App
bash
Copy
Edit
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f ingress.yaml
7. Add Host Mapping
Edit your /etc/hosts file:

bash
Copy
Edit
sudo nano /etc/hosts
Add the following line:

lua
Copy
Edit
127.0.0.1 openresty.local
8. Test the Application
bash
Copy
Edit
curl http://openresty.local/hello
Expected output:

csharp
Copy
Edit
Hello from sandhra!
🧹 Cleanup
To delete your KIND cluster:

bash
Copy
Edit
kind delete cluster --name prophaze
