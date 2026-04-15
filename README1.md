# 🚀 AWS 3-Tier Architecture (Production-Grade)
>  This project simulates a real-world enterprise cloud environment built using AWS and DevOps best practices.

## 📌 Overview
This project demonstrates a production-ready AWS 3-tier architecture using Infrastructure as Code (Terraform).

It simulates a real enterprise workload with secure networking, load balancing, and database isolation.

---

## 🏗️ Architecture

![Architecture](architecture/diagram.png)

### Components:
- VPC with public and private subnets across 2 AZs
- Application Load Balancer (ALB)
- EC2 Auto Scaling Group
- RDS (Multi-AZ)
- NAT Gateway for private subnet access

---

## 🔧 Technologies Used

- AWS (EC2, S3, VPC, IAM, RDS, ALB)
- Terraform (Infrastructure as Code)
- Bash / AWS CLI
- CloudWatch (Monitoring)

---

## ⚙️ Features

✔ Highly available architecture across multiple AZs  
✔ Secure networking (private subnets, no public DB access)  
✔ IAM least-privilege implementation  
✔ Infrastructure automation with Terraform  
✔ Monitoring with CloudWatch  

---

## 🔐 Security

- Private subnets for application and database layers  
- Security groups restrict traffic between tiers  
- IAM roles used instead of hardcoded credentials  
- Encryption enabled for storage and data  

---

## 📊 Monitoring & Logging

- CloudWatch metrics and alarms  
- Centralized logging  
- Health checks via ALB  

---

## 🚀 Deployment

```bash
terraform init
terraform plan
terraform apply