# lua based-OpenResty App on KIND with Ingress
##### Guide on how to build a Docker image for an OpenResty app, deploy it on a local Kubernetes cluster using KIND, and expose it via NGINX Ingress with custom domain.
---
#### 🧱 Prerequisites

- Docker
- kubectl
- KIND
- curl
  
### 🐳 Step 1: Build Docker Image
```
docker build -t openresty-hello:v1 .
```
Replace . with the correct context directory if your Dockerfile is in a subfolder.

### ⚙️ Step 2: Install KIND
Follow the official KIND installation guide.
https://kind.sigs.k8s.io/docs/user/quick-start/#installation

### ⛴️ Step 3: Create KIND Cluster with Port Mapping
Create a kind-cluster.yaml file with the following content:
```
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
```
```
kind create cluster --name <cluster-name> --config kind-cluster.yaml
```
It maps container ports to your host to expose services like HTTP (80), HTTPS (443), or custom ports like 30080.

### 🧭 Step 4: Set the New KIND Cluster as Current Context
```
kubectl config use-context <culster-name>
kubectl config current-context
```

### 🌐 Step 5: Install NGINX Ingress Controller
```
kubectl apply -f https://kind.sigs.k8s.io/examples/ingress/deploy-ingress-nginx.yaml
```

### 📦 Step 6: Load Docker Image into KIND
```
kind load docker-image openresty-hello:v1 --name <cluster-name>
```

###  🚀 Step 7: Apply Kubernetes Manifests
```
kubectl apply -f deployment.yaml
```

### 📝 Step 8: Edit /etc/hosts File
Add the following entry to your system’s /etc/hosts file:
```
127.0.0.1 openresty.local
```

### ✅ Step 9: Test the Application
```
curl http://openresty.local/hello
```
Expected output:
```
Hello from sandhra!
```

## 🧹 Cleanup 
To delete the cluster:
```
kind delete cluster --name <cluster-name>
```


