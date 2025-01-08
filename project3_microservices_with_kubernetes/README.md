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
### Installing AWS CLI

### Installing eksctl
eksctl is a tool that makes creating and managing EKS cluster on AWS a breeze.
To install simply execute (in Linux):
```bash
ARCH=amd64
PLATFORM=$(uname -s)_$ARCH
curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"
curl -sL "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_checksums.txt" | grep $PLATFORM | sha256sum --check
tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz
sudo mv /tmp/eksctl /usr/local/bin
```

### Creating and configuring EKS cluster
```bash
eksctl create cluster --name my-cluster --region us-east-1 --nodegroup-name my-nodes --node-type t3.small --nodes 1 --nodes-min 1 --nodes-max 2
```
After a few minutes, with the cluster created you may configure the context for using kubectl
```bash
aws eks --region us-east-1 update-kubeconfig --name my-cluster
```
And also check the context:
```bash
kubectl config current-context
```

### Configure a database for the service
First create the files PersistentVolumeClaim and PersistentVolume YAML files, `pvc.yaml` and `pv.yaml` respectively.
```yaml
# pvc.yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: postgresql-pvc
spec:
  storageClassName: gp2
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
```
```yaml
# pv.yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: my-manual-pv
spec:
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: gp2
  hostPath:
    path: "/mnt/data"
```

Next check for storage class:
```bash
kubectl get storageclass
```

The output should be something like:
```
NAME   PROVISIONER             RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
gp2    kubernetes.io/aws-ebs   Delete          WaitForFirstConsumer   false                  10m
```
 And create a `postgres-deployment.yaml` file:
 ```yaml
 apiVersion: apps/v1
kind: Deployment
metadata:
  name: postgresql
spec:
  selector:
    matchLabels:
      app: postgresql
  template:
    metadata:
      labels:
        app: postgresql
    spec:
      containers:
      - name: postgresql
        image: postgres:latest
        env:
        - name: POSTGRES_DB
          value: mydatabase
        - name: POSTGRES_USER
          value: myuser
        - name: POSTGRES_PASSWORD
          value: mypassword
        ports:
        - containerPort: 5432
        volumeMounts:
        - mountPath: /var/lib/postgresql/data
          name: postgresql-storage
      volumes:
      - name: postgresql-storage
        persistentVolumeClaim:
          claimName: postgresql-pvc
 ```

And finally, apply YAML configurations to the cluster:
```bash
kubectl apply -f pvc.yaml
kubectl apply -f pv.yaml
kubectl apply -f postgresql-deployment.yaml
```
Check if the pods are running:
```bash
kubectl get pods
```
You should get something like:
```
NAME                          READY   STATUS    RESTARTS   AGE
postgresql-77d75d45d5-p29fx   1/1     Running   0          84s
```

### Accessing the Postgres database
We can access the Postgres deployed on the EKS cluster through `kubectl` command:



### Deleting the EKS cluster
```bash
eksctl delete cluster --name my-cluster --region us-east-1
```


## Drafting the project steps:
-[x] Fork and clone repo
-[x] Create AWS user for using CLI
-[x] Install eksctl
-[x] Create k8s cluster on AWS with eksctl
-[x] Delete k8s cluster on AWS with eksctl
-[x] Configuring kubectl to interect with EKS cluster
-[ ]
-[ ]
-[ ]

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
