# AWS 3-Tier Architecture Design Document

## 1. Purpose

This document describes the design of a production-style 3-tier AWS architecture built with Terraform.

The goal of the design is to provide a secure, scalable, and highly available infrastructure pattern suitable for enterprise web applications.

---

## 2. Architecture Summary

This environment is based on live Terraform state from:

`realproject/3tier/env/dev`

It includes:

- One VPC in `us-east-2`
- Six subnets across two Availability Zones
- Public web tier
- Private application tier
- Private database tier
- Internet-facing Application Load Balancer
- Auto Scaling Group for compute capacity
- Amazon RDS MySQL with Multi-AZ deployment
- NAT Gateways for outbound internet access from private subnets
- VPC Flow Logs to CloudWatch
- Security groups and NACLs per tier

---

## 3. Design Goals

The architecture is designed to achieve the following:

- High availability across multiple Availability Zones
- Secure separation of web, app, and database layers
- Scalable compute layer with Auto Scaling
- Private database access only
- Centralized monitoring and network visibility
- Infrastructure consistency through Terraform

---

## 4. Network Design

### VPC
- CIDR block: `10.0.0.0/16`

### Subnet Layout
Across two Availability Zones:
- 2 Web subnets (public)
- 2 App subnets (private)
- 2 DB subnets (private)

### Internet Access
- Internet Gateway attached to the VPC
- Public subnets route internet-bound traffic through the IGW

### Private Egress
- Two NAT Gateways, one per AZ
- Private app subnets use NAT for outbound access
- Database subnets remain private

---

## 5. Application Delivery Design

### Public Entry Point
The environment uses an internet-facing Application Load Balancer.

Purpose:
- Accept inbound web traffic
- Distribute traffic across application instances
- Perform target health checks

### Compute Tier
The compute tier uses an Auto Scaling Group.

Configuration:
- Minimum capacity: 2
- Desired capacity: 2
- Maximum capacity: 3

Instances are launched using a Launch Template and placed in private application subnets.

---

## 6. Database Design

The database tier uses Amazon RDS MySQL.

Key characteristics:
- Private endpoint only
- Port 3306
- Multi-AZ enabled
- Standby replica in `us-east-2b`

This supports:
- High availability
- Better resilience during failure scenarios
- Reduced exposure by keeping the database private

---

## 7. Security Design

### Security Groups
Separate security groups are used for:
- Load balancer
- Application instances
- Database instance

Traffic pattern:
- Internet to ALB
- ALB to app tier
- App tier to database tier

### Network ACLs
Dedicated NACLs are applied per tier to provide additional subnet-level traffic control.

### Access Management
AWS Systems Manager is preferred for instance management, reducing the need for direct SSH access.

### Security Objectives
- No public access to app tier
- No public access to database tier
- Controlled tier-to-tier communication
- Improved auditability and operational security

---

## 8. Monitoring and Logging

Monitoring is implemented using:
- Amazon CloudWatch
- VPC Flow Logs

Benefits:
- Infrastructure performance visibility
- Traffic analysis
- Security event investigation
- Troubleshooting of connectivity issues

---

## 9. Routing Design

Dedicated route tables are used for:
- Web tier
- App tier
- DB tier

This improves:
- Traffic isolation
- Predictable network paths
- Clear separation of public and private routing logic

---

## 10. Availability and Resilience

The architecture improves resilience by:
- Spreading subnets across two AZs
- Using an ALB across multiple subnets
- Running multiple EC2 instances in an Auto Scaling Group
- Enabling Multi-AZ on RDS
- Using two NAT Gateways for outbound redundancy

---

## 11. Cost Considerations

Major cost drivers include:
- NAT Gateways
- EC2 instances
- RDS Multi-AZ
- ALB
- CloudWatch logs and metrics

Optimization opportunities:
- Right-size EC2 instances
- Review NAT data transfer costs
- Adjust log retention
- Use environment-specific sizing for dev, qa, and prod

---

## 12. Deployment Model

Terraform is used to manage infrastructure lifecycle.

Typical workflow:
1. `terraform init`
2. `terraform validate`
3. `terraform plan`
4. `terraform apply`

State validation commands were also used to confirm live infrastructure design.

---

## 13. Suitable Use Cases

This architecture pattern is suitable for:
- E-commerce platforms
- Internal enterprise applications
- API backends
- Regulated workloads requiring layered security

---

## 14. Conclusion

This 3-tier AWS design demonstrates a practical enterprise infrastructure pattern using Terraform. It balances security, scalability, availability, and operational visibility while following modern cloud engineering best practices.