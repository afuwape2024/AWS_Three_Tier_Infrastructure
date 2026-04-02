output "iam_role_vpc_flow_log" {
  description = "IAM role name used by VPC Flow Logs"
  value       = aws_iam_role.iam_role_vpc_flow_log.id
}

output "iam_role_vpc_flow_log_arn" {
  description = "IAM role ARN for VPC Flow Logs"
  value       = aws_iam_role.iam_role_vpc_flow_log.arn
}

# Optional compatibility output (if referenced elsewhere)
output "vpc_flow_logs_iam_role_arn" {
  description = "IAM role ARN for VPC Flow Logs"
  value       = aws_iam_role.iam_role_vpc_flow_log.arn
}