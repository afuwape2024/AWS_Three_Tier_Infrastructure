output "tier_vpc_cloudwatch_id" {
  description = "CloudWatch Log Group ID used by VPC Flow Logs"
  value       = aws_cloudwatch_log_group.tier_vpc_cloudwatch.id
}

output "tier_vpc_cloudwatch_arn" {
  description = "CloudWatch Log Group ARN"
  value       = aws_cloudwatch_log_group.tier_vpc_cloudwatch.arn
}
