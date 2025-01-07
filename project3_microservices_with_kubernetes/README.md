# Project 3: Operationalizing a Microservice with Kubernetes
## Overview

## Project Scenario
The project official description is the following:
```
## Project: Coworking Space Service

The Coworking Space Service is a set of APIs that enables users to request one-time tokens and administrators to authorize access to a coworking space.

This service follows a microservice pattern and the APIs are split into distinct services that can be deployed and managed independently of one another.

For this project, you are a DevOps engineer who will be collaborating with a team that is building an API for business analysts. The API provides business analysts with basic analytics data on user activity in the coworking space service. The application they provide you functions as expected, and you will help build a pipeline to deploy it to Kubernetes.
```
![Project Description Diagram](images/project.jpeg)

## Objectives
Based on the description, we have the following project objectives:
1. 
2. 

## Project Instructions

1. Set up a Postgres database.
2. Create a Dockerfile for the Python application.
    a. You'll submit the Dockerfile
3. Write a simple build pipeline with AWS CodeBuild to build and push a Docker image into AWS ECR.
    - Take a screenshot of AWS CodeBuild pipeline for your project submission.
    - Take a screenshot of AWS ECR repository for the application's repository.
4. Create a service and deployment using Kubernetes configuration files to deploy the application.
5. You'll submit all the Kubernetes config files used for deployment (ie YAML files).
    - Take a screenshot of running the kubectl get svc command.
    - Take a screenshot of kubectl get pods.
    - Take a screenshot of kubectl describe svc <DATABASE_SERVICE_NAME>.
    - Take a screenshot of kubectl describe deployment <SERVICE_NAME>.
6. Check AWS CloudWatch for application logs.
    - Take a screenshot of AWS CloudWatch Container Insights logs for the application.
7. Create a README.md file in your solution that serves as documentation for your user to detail how your deployment process works and how the user can deploy changes. The details should not simply rehash what you have done on a step by step basis. Instead, it should help an experienced software developer understand the technologies and tools in the build and deploy process as well as provide them insight into how they would release new builds.

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
Next, check the local minikube cluster namespace:
```bash
kubectl get namespace
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
