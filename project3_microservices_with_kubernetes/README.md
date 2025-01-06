# Project 3: Operationalizing a Microservice with Kubernetes
## Overview

## Project Scenario
The project official description is the following:
```

```
![Project Description Diagram](images/project.jpeg)

## Objectives
Based on the description, we have the following project objectives:
1. 
2. 

## Installing tools and packages
### Installing Docker

### Installing Kubectl
```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
```

### Local development with Minikube
We are going to use Minikube for initial testing locally, preventing unecessary cloud cost.
To install it on a local Linux machine:
```bash
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64
```

After installation, we can start Minikube:
```bash
minikube start
```
```bash
minikube kubectl -- get po -A
```

### Kubectl

- Checking logs
```bash
kubectl logs <POD_NAME> -c <CONTAINER_NAME>
```

- Debugging with Kubernetes
```

## References
- [Minikube start](https://minikube.sigs.k8s.io/docs/start/?arch=%2Flinux%2Fx86-64%2Fstable%2Fbinary+download)
