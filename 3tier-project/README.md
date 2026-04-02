
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
- Note we 


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







