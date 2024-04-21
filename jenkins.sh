#!/bin/bash

# Check if the script is being run with root privileges
if [ "$(id -u)" -ne 0 ]; then
    echo "Please run this script with sudo or as root."
    exit 1
fi

# Install Jenkins
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum install jenkins -y

# Start Jenkins service
systemctl start jenkins

# Enable Jenkins service to start on boot
systemctl enable jenkins

# Install Java 17
sudo yum install -y java-17

# Give sudo powers without password
chmod 660 /etc/sudoers.d/90-cloud-init-users
echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/90-cloud-init-users
chmod 440 /etc/sudoers.d/90-cloud-init-users

# Installing git
sudo yum install git -y

# Configuring docker 
sudo yum install docker -y
sudo systemctl start docker 
sudo systemctl enable docker 
# sudo systemctl status docker 
sudo usermod -aG docker ec2-user 
sudo usermod -aG docker jenkins 
sudo systemctl restart docker

# Obtaining jenkins password
sleep 12
echo "USE THIS SECRETE PASSWD TO CONFIGURE JENKINS"
sleep 20
cat /var/lib/jenkins/secrets/initialAdminPassword
