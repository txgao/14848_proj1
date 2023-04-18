#!/bin/bash

# Deploy all resources
echo "Deploying workloads and services..."
cd option1
kubectl create -f spark/
kubectl create -f jupyter/
kubectl create -f hadoop/
kubectl create -f sonar/

# Wait for resources to be ready
echo "Wait for resources to be created..."
sleep 60   # pause for 60 seconds
echo "...Finished!"

# Retrieve all the service IP
echo "Retrieving service IP..."
rm -rf src/services
mkdir src/services
kubectl get svc jupyter-service -o json > src/services/jupyter.json
kubectl get svc namenode -o json > src/services/hadoop.json
kubectl get svc sonarscanner -o json > src/services/sonarscanner.json
kubectl get svc spark -o json > src/services/spark.json

# Build app docker
echo "Build App Docker..."
cd src
USERNAME=$(docker info | grep Username | awk '{print $2}')
docker build -f Dockerfile -t "${USERNAME}/finalproject" .
docker push "${USERNAME}/finalproject"
cd ..

# Deploy the application
echo "Deploying Main App..."
sed -i "s|DOCKER_USERNAME|${USERNAME}|g" app.yaml
kubectl apply -f app.yaml