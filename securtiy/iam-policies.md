# IAM Policies and Security Approach

## Overview

This document describes the IAM and access control approach for the AWS 3-tier Terraform project.

The goal is to follow the principle of least privilege while enabling secure infrastructure deployment, administration, and monitoring.

---

## Security Principles

- Least privilege access
- Role-based access control
- No hardcoded credentials
- Prefer IAM roles over IAM users
- Separate permissions by function
- Log and monitor privileged actions

---

## Recommended IAM Roles

### 1. Terraform Deployment Role
Purpose:
- Used by Jenkins, CI/CD, or administrators to provision infrastructure

Permissions should include access to:
- EC2
- VPC
- IAM (limited to required role/profile creation)
- ELB / ALB
- Auto Scaling
- RDS
- CloudWatch
- Logs
- SSM
- KMS
- S3 (for remote state, if used)

Important:
- Scope actions to approved resources where practical
- Limit destructive actions in production

---

### 2. EC2 Instance Role
Purpose:
- Attached to application instances launched by the Auto Scaling Group

Permissions may include:
- CloudWatch agent publishing
- SSM managed instance access
- Read access to approved parameters or secrets
- Access to specific S3 buckets if required by the application

Recommended managed policies:
- `AmazonSSMManagedInstanceCore`

Optional:
- Custom policy for CloudWatch Logs publishing
- Custom policy for Secrets Manager or Parameter Store access

---

### 3. RDS Monitoring / Enhanced Monitoring Role
Purpose:
- Supports RDS monitoring where enhanced monitoring is enabled

Permissions:
- CloudWatch Logs publishing as required by AWS managed integrations

---

## IAM Policy Design Recommendations

### Terraform / CI-CD
Use a dedicated role such as:
- `terraform-deployment-role`
- `jenkins-terraform-role`

Best practices:
- Assume role through STS
- Do not embed access keys in Jenkinsfiles
- Rotate any temporary credentials automatically

### Human Access
Use federated identity or AWS IAM Identity Center where possible.

Best practices:
- Separate admin and read-only access
- Require MFA for console access
- Restrict production access to approved engineers only

---

## Example Access Model

### Read-Only Role
Can:
- View EC2, VPC, ALB, RDS, CloudWatch, IAM role metadata
- Review logs and monitoring dashboards

Cannot:
- Modify infrastructure
- Delete resources
- Change IAM permissions

### Operations Role
Can:
- Restart instances
- Review logs
- Access systems through SSM
- Support incident response

Cannot:
- Change core IAM policies without approval

### Deployment Role
Can:
- Run Terraform plan/apply/destroy in approved environments
- Create and update infrastructure resources

Restrictions:
- Production apply/destroy should require approval

---

## Logging and Audit

Enable and review:
- AWS CloudTrail
- CloudWatch Logs
- VPC Flow Logs

Audit focus:
- IAM policy changes
- Security group changes
- Route table changes
- RDS configuration changes
- Destructive Terraform actions

---

## Secrets Management

Do not store secrets in:
- Terraform variables files committed to Git
- Jenkinsfiles
- User data in plain text

Use:
- AWS Secrets Manager
- AWS Systems Manager Parameter Store
- KMS encryption for sensitive values

---

## Network Security Alignment

IAM works together with:
- Security groups
- Network ACLs
- Private subnets
- SSM-based instance access

This project avoids:
- Direct SSH exposure to private instances
- Public database access
- Overly permissive IAM access

---

## Recommended Managed Policies

Use AWS managed policies sparingly and prefer custom policies where possible.

Common examples:
- `AmazonSSMManagedInstanceCore`
- `CloudWatchAgentServerPolicy` if CloudWatch agent is installed

---

## Policy Review Checklist

Before production deployment, confirm:
- Roles are scoped to required actions only
- No wildcard `*` permissions unless unavoidable and documented
- MFA is required for privileged users
- CloudTrail is enabled
- Secrets are stored securely
- CI/CD uses roles instead of long-lived keys

---

## Summary

A strong IAM design is essential for secure AWS operations. For this project, IAM should support Terraform automation, secure EC2 management through SSM, monitoring integrations, and controlled human access with least privilege.