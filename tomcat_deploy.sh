#!/bin/bash

# Define variables
IMAGE_NAME="test-tomcat"
CONTAINER_NAME="test-tomcat-container"
ENVIRONMENT="DEV"  # or PROD based on your needs

# Build the Docker image
echo "Building Docker image..."
docker build --no-cache -t $IMAGE_NAME .

# Remove any existing container
echo "Removing existing container (if any)..."
docker rm -f $CONTAINER_NAME 2>/dev/null || true

# Run the Docker container with the necessary configurations
echo "Running Docker container..."
docker run --privileged=true -d -p 8081:8080 --name $CONTAINER_NAME $IMAGE_NAME

# Wait for Tomcat to start
echo "Waiting for Tomcat to start..."
sleep 10

# Execute the test script inside the container
echo "Executing the test script..."
docker exec -it $CONTAINER_NAME /data/tomcat_test.sh --extra-vars="env=${ENVIRONMENT}"

# Cleanup (optional, if you want to remove the container after testing)
echo "Cleaning up..."
docker rm -f $CONTAINER_NAME
