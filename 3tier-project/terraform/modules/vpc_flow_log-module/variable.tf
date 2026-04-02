variable "new_vpc" {
  description = "VPC ID for flow logs"
  type        = string
}

variable "tier_vpc_cloudwatch_arn" {
  description = "CloudWatch Log Group ARN for VPC Flow Logs"
  type        = string
}

variable "vpc_flow_logs_iam_role_arn" {
  description = "IAM role ARN for VPC Flow Logs"
  type        = string
}

variable "traffic_type" {
  description = "Type of traffic to capture: ACCEPT, REJECT, or ALL"
  type        = string
  default     = "ALL"
}

