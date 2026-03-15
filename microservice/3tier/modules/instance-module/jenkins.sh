#!/bin/bash
set -e

echo "Updating system..."
apt update -y

# Install Java (Required for Jenkins)
echo "Installing Java..."
apt install -y fontconfig openjdk-21-jre

sleep 10
# Install Jenkins
echo "Installing Jenkins..."

sudo mkdir -p /etc/apt/keyrings

wget -O /tmp/jenkins.io-2026.key https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key
sudo mv /tmp/jenkins.io-2026.key /etc/apt/keyrings/jenkins-keyring.asc

echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | \
sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

apt update -y
apt install -y jenkins


systemctl enable jenkins
systemctl start jenkins

## Install Git
sleep 15
echo "Installing Git..."
apt install -y git


# Install Terraform

sudo apt-get update -y
sudo apt-get install -y gnupg software-properties-common curl
curl -fsSL https://apt.releases.hashicorp.com/gpg | \
  sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(. /etc/os-release && echo $VERSION_CODENAME) main" | \
  sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt-get update -y
sudo apt-get install -y terraform
terraform version

# Install kubectl
echo "Installing kubectl..."

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

chmod +x kubectl

sudo mv kubectl /usr/local/bin/kubectl

kubectl version --client

# Show installed versions
echo "Installed versions:"
java -version
git --version
terraform version
kubectl version --client

echo "Setup complete!" 

# echo "Installed versions:"
# java -version
# jenkins --version || true
# docker --version
# mvn -version
# node -v
# npm -v
# aws --version
# terraform -version
# kubectl version --client
# helm version

#######################################################################
# echo "Jenkins initial admin password:"
# sudo cat /var/lib/jenkins/secrets/initialAdminPassword
# aws sts get-caller-identity

# aws configure 
# Configure → Build Triggers → Poll SCM → Schedule: * * * * *
# GitHub → Settings → Webhooks → Add Webhook
# http://YOUR_JENKINS_URL/github-webhook/