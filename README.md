
# 3-Tier AWS Infrastructure

## Architecture Overview (From Terraform State)

This overview is based on live state from `realproject/3tier/env/dev` using `terraform state list` and `terraform state show`.

- Region: us-east-2
- VPC: one VPC (`10.0.0.0/16`)
- Subnets: 6 total across 2 AZs (web/app/db x 2)
- Internet edge: one Internet Gateway
- Public entry tier: one internet-facing Application Load Balancer across two web subnets
- Compute tier: one Auto Scaling Group attached to ALB target group (min 2, desired 2, max 3)
- Compute build with lunch template 
- Egress tier: two NAT Gateways (one per AZ)
- Routing: dedicated route tables and associations for web, app, and database tiers
- Network controls: separate security groups and NACLs for web, app, and db tiers
- Database tier: one RDS MySQL primary instance (Multi-AZ enabled, private, port 3306) which include replical into us-east-2b
- Database endpoint is private inside the VPC
- VPC flow logs send logs to cloudwatch 



![Three-tier architecture diagram](https://miro.medium.com/v2/resize:fit:1358/1*TCwcsibobVZsXEZEH6C-6w.png)

## State Commands Used

```bash
cd realproject/3tier/env/dev
terraform state list
terraform state show module.vpc.aws_vpc.new_vpc
terraform state show module.load_balancer.aws_lb.application_lb
terraform state show module.autoscaling.aws_autoscaling_group.web_scaling_group
terraform state show module.database_mysql.aws_db_instance.database_mysql_primary
```

#================================================================================
#=============================================================================

# 3-Tier AWS Infrastructure

## Architecture Overview (From Terraform State)

This overview is based on live state from `realproject/3tier/env/dev` using `terraform state list` and `terraform state show`.

- Environment Details
Region: us-east-2
VPC CIDR: 10.0.0.0/16
Availability Zones: 2 (Multi-AZ architecture)

- Network Layer
1 VPC
6 Subnets:
Web Tier (Public) ×2
App Tier (Private) ×2
DB Tier (Private) ×2

-Routing
Separate route tables for:
Web Tier (public routing via IGW)
App Tier (private routing via NAT)
DB Tier (isolated private routing)
Explicit subnet associations

- Load Balancing Layer
Public Load Balancer
Internet-facing Application Load Balancer
Deployed across web subnets
Handles incoming HTTP/HTTPS traffic
Internal Load Balancer
Internal Application Load Balancer (private)
Routes traffic within VPC
Enhances security and service isolation

- Compute Layer
Auto Scaling Group (ASG):
Min: 2
Desired: 2
Max: 3
Launch Template used for instance configuration
Instances deployed in private app subnets
Registered with ALB Target Group

- Database Layer
Amazon RDS (MySQL)
Multi-AZ enabled
Primary + standby replica (us-east-2b)
Private endpoint (no public access)
Port: 3306

- Security
Separate Security Groups for:
Web Tier
App Tier
DB Tier
Security Group chaining:
ALB → App → DB
Network ACLs per tier
No direct internet access to:
App servers
Database

- instance Security
System manager

- Observability & Monitoring
VPC Flow Logs enabled
Logs sent to CloudWatch
Enables:
Traffic analysis
Security monitoring
Troubleshooting

- Tech Stack
AWS Services
VPC
EC2
Application Load Balancer (ALB)
Auto Scaling Group
RDS (MySQL)
NAT Gateway
CloudWatch
VPC Flow Logs
Infrastructure as Code
Terraform

https://kodekloud.com/kk-media/image/upload/v1752860152/notes-assets/images/AWS-Certified-SysOps-Administrator-Associate-Multi-AZ-Architectures-for-Various-AWS-Services-Overview/multi-az-architecture-aws-vpc.jpg

## State Commands Used
Terraform init
Terraform validate
Terraform plan
Terraform apply -auto-approve












