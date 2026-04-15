# CloudWatch Monitoring Configuration

## Overview

This document describes the monitoring approach for the AWS 3-tier architecture deployed in `us-east-2`.

The environment uses Amazon CloudWatch and VPC Flow Logs to provide visibility into infrastructure health, performance, and network activity.

---

## Monitoring Objectives

The monitoring configuration is designed to:

- Track application and infrastructure health
- Detect performance degradation early
- Support incident response and troubleshooting
- Monitor network activity using VPC Flow Logs
- Improve operational visibility across web, app, and database tiers

---

## Services Monitored

### 1. Application Load Balancer (ALB)
Monitor:
- `RequestCount`
- `HTTPCode_ELB_5XX_Count`
- `HTTPCode_Target_5XX_Count`
- `TargetResponseTime`
- `HealthyHostCount`
- `UnHealthyHostCount`

Purpose:
- Detect traffic spikes
- Identify backend failures
- Monitor target health

---

### 2. EC2 / Auto Scaling Group
Monitor:
- `CPUUtilization`
- `StatusCheckFailed`
- `NetworkIn`
- `NetworkOut`
- `DiskReadOps`
- `DiskWriteOps`

Purpose:
- Detect resource saturation
- Identify unhealthy instances
- Validate scaling behavior

---

### 3. RDS MySQL
Monitor:
- `CPUUtilization`
- `FreeStorageSpace`
- `DatabaseConnections`
- `ReadLatency`
- `WriteLatency`
- `FreeableMemory`

Purpose:
- Track database health
- Detect storage or connection issues
- Monitor database performance over time

---

### 4. NAT Gateways
Monitor:
- `BytesInFromDestination`
- `BytesOutToDestination`
- `PacketsInFromSource`
- `PacketsOutToDestination`
- `ErrorPortAllocation`

Purpose:
- Detect outbound traffic bottlenecks
- Identify NAT scaling or connection issues

---

### 5. VPC Flow Logs
Flow Logs are enabled and sent to CloudWatch Logs.

Purpose:
- Analyze accepted and rejected network traffic
- Support security monitoring
- Troubleshoot connectivity issues between web, app, and db tiers

---

## Recommended CloudWatch Alarms

### ALB Alarms
- Unhealthy host count > 0 for 5 minutes
- Target 5XX count above threshold
- High response time over baseline

### EC2 Alarms
- CPU utilization > 80% for 10 minutes
- Status check failed > 0
- Low instance count in Auto Scaling Group

### RDS Alarms
- CPU utilization > 75%
- Free storage space below threshold
- Database connections approaching limit

### NAT Gateway Alarms
- Port allocation errors > 0
- Unusual traffic spikes

---

## Logging Strategy

### CloudWatch Logs
Use CloudWatch Logs for:
- Application logs
- System logs
- VPC Flow Logs
- Bootstrapping or user data logs

### Retention
Recommended log retention:
- Dev: 14 days
- QA: 30 days
- Prod: 90 days or more based on compliance requirements

---

## Dashboards

Recommended CloudWatch dashboard widgets:
- ALB request count and target health
- EC2 CPU utilization by instance
- Auto Scaling desired vs in-service instances
- RDS CPU, connections, and free storage
- NAT Gateway traffic
- VPC Flow Logs volume trend

---

## Incident Response Use Cases

CloudWatch helps support:
- Application outage troubleshooting
- Target group health check failures
- Sudden increase in HTTP 5XX responses
- RDS connectivity or storage issues
- Unexpected rejected traffic in VPC Flow Logs

---

## Future Enhancements

- Add SNS notifications for alarm actions
- Integrate CloudWatch alarms with email or Slack
- Add custom application metrics
- Centralize logs into Splunk or OpenSearch
- Create production-ready dashboards per environment

---

## Summary

CloudWatch and VPC Flow Logs provide the operational foundation for monitoring this 3-tier AWS architecture. This setup improves visibility, supports incident response, and helps maintain performance, availability, and security.