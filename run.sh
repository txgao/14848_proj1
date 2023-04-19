#!/bin/bash

# Deploy all resources
echo "Deploying workloads and services..."
cd option1
kubectl create -f hadoop/
kubectl create -f spark/
kubectl create -f jupyter/
kubectl create -f sonar/

# Wait for deployment to be ready
echo "Waiting for deployment to be ready..."
while [[ $(kubectl rollout status deployment/namenode) != *"successfully rolled out"* ]] || \
      [[ $(kubectl rollout status deployment/datanode) != *"successfully rolled out"* ]] || \
      [[ $(kubectl rollout status deployment/spark) != *"successfully rolled out"* ]] || \
      [[ $(kubectl rollout status deployment/jupyter) != *"successfully rolled out"* ]] || \
      [[ $(kubectl rollout status deployment/sonarscanner) != *"successfully rolled out"* ]]; do
    echo "Waiting for deployments to be ready..."
    sleep 10
done

# Wait for services to be ready
echo "Waiting for services to be ready..."
while [[ $(kubectl get services -o jsonpath='{.items[?(@.metadata.name=="spark")].status.loadBalancer.ingress}') == "" ]] || \
      [[ $(kubectl get services -o jsonpath='{.items[?(@.metadata.name=="namenode")].status.loadBalancer.ingress}') == "" ]] || \
      [[ $(kubectl get services -o jsonpath='{.items[?(@.metadata.name=="sonarscanner")].status.loadBalancer.ingress}') == "" ]] || \
      [[ $(kubectl get services -o jsonpath='{.items[?(@.metadata.name=="jupyter-service")].status.loadBalancer.ingress}') == "" ]]; do
    echo "Waiting for services to be ready..."
    sleep 10
done
echo "Deployment all done!"

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

# Wait for the application deployment to be done
echo "Waiting for application to be ready..."
while [[ $(kubectl rollout status deployment/app-deployment) != *"successfully rolled out"* ]]|| \
      [[ $(kubectl get services -o jsonpath='{.items[?(@.metadata.name=="my-app")].status.loadBalancer.ingress}') == "" ]]; do
    echo "Waiting for application to be ready..."
    sleep 10
done

# Show the application URL
DEPLOYMENT_URL=$(kubectl get services my-app -o jsonpath='{.status.loadBalancer.ingress[0].ip}:{.spec.ports[0].port}')
echo "Application is now running at $DEPLOYMENT_URL"

# Remove the services folder
rm -rf src/services
