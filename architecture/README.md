# Architecture Diagram

This diagram represents the production-style 3-tier AWS infrastructure deployed using Terraform.

## Key Components

- VPC (10.0.0.0/16)
- 2 Availability Zones (us-east-2a, us-east-2b)
- Public Web Tier (ALB + public subnets)
- Private Application Tier (Auto Scaling Group)
- Private Database Tier (RDS MySQL Multi-AZ)
- NAT Gateways for outbound traffic
- VPC Flow Logs integrated with CloudWatch

## Traffic Flow

Internet → ALB → Application Tier → Database Tier

## Notes

- Application and database tiers are not publicly accessible
- NAT Gateways provide secure outbound access
- Multi-AZ ensures high availability and fault tolerance
- CloudWatch and VPC Flow Logs provide observability

## Diagram Source

Editable version available in:
`diagram.drawio`