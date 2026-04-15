# 🚀 AWS 3-Tier Architecture (Production-Grade | Terraform)

> ⚡ This project simulates a real-world enterprise cloud environment built using AWS and DevOps best practices.

---

## 📌 Overview

This project implements a **highly available, secure, and scalable 3-tier architecture on AWS** using Terraform.

The architecture is built and validated from a **live Terraform state** located at:

`realproject/3tier/env/dev`

State inspection was performed using:
- `terraform state list`
- `terraform state show`

---

## 🏗️ Architecture

![Three-tier architecture diagram](https://miro.medium.com/v2/resize:fit:1358/1*TCwcsibobVZsXEZEH6C-6w.png)

---

## 🌍 Environment Details

- **Region:** us-east-2  
- **VPC CIDR:** 10.0.0.0/16  
- **Availability Zones:** 2 (Multi-AZ architecture)  

---

## 🌐 Network Layer

- 1 VPC (`10.0.0.0/16`)
- 6 Subnets across 2 AZs:
  - Web Tier (Public) ×2  
  - App Tier (Private) ×2  
  - DB Tier (Private) ×2  

### Routing
- Dedicated route tables per tier:
  - Web Tier → Internet Gateway (IGW)
  - App Tier → NAT Gateway
  - DB Tier → Fully isolated (no internet access)
- Explicit subnet associations for traffic control

---

## ⚖️ Load Balancing Layer

### Public Load Balancer
- Internet-facing **Application Load Balancer (ALB)**
- Deployed across web subnets
- Handles incoming HTTP/HTTPS traffic

### Internal Load Balancer
- Private ALB for internal service communication
- Enhances service isolation and security

---

## ⚙️ Compute Layer

- **Auto Scaling Group (ASG)**
  - Min: 2
  - Desired: 2
  - Max: 3
- Launch Template used for EC2 configuration
- Instances deployed in **private app subnets**
- Integrated with ALB Target Group

---

## 🗄️ Database Layer

- **Amazon RDS (MySQL)**
  - Multi-AZ enabled
  - Primary + standby replica (us-east-2b)
  - Private endpoint (no public access)
  - Port: 3306

---

## 🔐 Security Architecture

### Network Security
- Separate Security Groups for:
  - Web Tier
  - App Tier
  - DB Tier

### Security Group Flow
Internet → ALB → App Servers → Database


### Additional Controls
- Network ACLs per tier
- No direct internet access to:
  - Application servers
  - Database layer
- AWS Systems Manager used for instance access (no SSH exposure)

---

## 📊 Observability & Monitoring

- VPC Flow Logs enabled
- Logs sent to **CloudWatch**

### Enables:
- Traffic analysis
- Security monitoring
- Troubleshooting network issues

---

## 🌐 Egress Architecture

- 2 NAT Gateways (one per AZ)
- Provides high availability for outbound traffic from private subnets

---

## 🧰 Technology Stack

### AWS Services
- VPC  
- EC2  
- Application Load Balancer (ALB)  
- Auto Scaling Group  
- RDS (MySQL)  
- NAT Gateway  
- CloudWatch  
- VPC Flow Logs  

### Infrastructure as Code
- Terraform  

---

## ⚙️ Terraform Commands Used

```bash
cd realproject/3tier/env/dev

terraform init
terraform validate
terraform plan
terraform apply -auto-approve
