#!/bin/bash

# Create a Docker network
docker network create jenkins-network 2>/dev/null

# Remove existing Docker containers if they exist
docker stop jenkins postgres 2>/dev/null
docker rm jenkins postgres 2>/dev/null

# Step 1: Start Jenkins container on the created network
docker run -d -p 8080:8080 -p 50000:50000 --network jenkins-network --name jenkins jenkins/jenkins:lts

# Step 2: Start PostgreSQL container on the same network
docker run -d --network jenkins-network --name postgres -e POSTGRES_PASSWORD=mysecretpassword -p 5432:5432 postgres

# Function to wait for Jenkins to be fully up and running
wait_for_jenkins() {
    echo "Waiting for Jenkins to start..."
    while ! docker exec jenkins curl -s http://localhost:8080/login; do
        sleep 5
        echo "Waiting for Jenkins web interface..."
    done
}

wait_for_jenkins

# Install Python, create a virtual environment, and install dependencies in the Jenkins container
docker exec -u 0 jenkins apt-get update
docker exec -u 0 jenkins apt-get install -y python3 python3-pip python3-venv
docker exec -u 0 jenkins python3 -m venv /opt/venv
docker exec -u 0 jenkins /opt/venv/bin/pip install pytest psycopg2-binary

# Copy test script and requirements.txt to the Jenkins container
docker cp test_db.py jenkins:/var/jenkins_home/test_db.py
docker cp requirements.txt jenkins:/var/jenkins_home/requirements.txt

# Execute the tests
docker exec -u 0 jenkins /bin/bash -c "source /opt/venv/bin/activate && pytest /var/jenkins_home/test_db.py"
