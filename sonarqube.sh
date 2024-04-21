#!/bin/bash
#First update the system with comand.... 
  sudo yum update -y

#Run the following to install docker,start,check status and enable.....
  sudo yum install docker -y
  sudo systemctl start docker
  sudo systemctl enable docker

#Run the command below to add docker to the group ec2-user ....
  sudo usermod -aG docker ec2-user

#Type exit comand to disconnect and reconnect to your instance.....
 ssh -i "name of pem" ec2-user@ip address

#Check if docker is working.....
  docker ps

#Install sonarqube plugins with the following commands.....
  mkdir -p ~/.docker/cli-plugins/
  curl -SL https://github.com/docker/compose/releases/download/v2.24.5/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose
  chmod +x ~/.docker/cli-plugins/docker-compose
  docker compose version

  vim docker-compose.yaml
version: '2'
services:
  sonarqube:
    image: sonarqube:latest
    ports:
      - "9000:9000"
    environment:
      - SONAR_JDBC_URL=jdbc:postgresql://db:5432/sonar
      - SONAR_JDBC_USERNAME=sonar
      - SONAR_JDBC_PASSWORD=sonarpasswd
    volumes:
      - sonarqube_data:/opt/sonarqube/data
      - sonarqube_extensions:/opt/sonarqube/extensions
      - sonarqube_logs:/opt/sonarqube/logs
    mem_limit: 2500m
    cpu_shares: 512

  db:
    image: postgres
    environment:
      - POSTGRES_DB=sonar
      - POSTGRES_USER=sonar
      - POSTGRES_PASSWORD=sonarpasswd
    volumes:
      - postgresql_data:/var/lib/postgresql/data
    mem_limit: 1500m
    cpu_shares: 512

volumes:
  sonarqube_data:
  sonarqube_extensions:
  sonarqube_logs:
  postgresql_data:
 sudo vim /etc/sysctl.conf
vm.max_map_count=262144
 sudo sysctl -p
 docker compose up -d
