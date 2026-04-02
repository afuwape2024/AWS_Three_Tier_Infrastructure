output "tier_vpc_flow_logs_id" {
  description = "VPC Flow Log ID"
  value       = aws_flow_log.tier_vpc_flow_logs.id
}

output "tier_vpc_flow_logs_arn" {
  description = "VPC Flow Log ARN"
  value       = aws_flow_log.tier_vpc_flow_logs.arn
}

