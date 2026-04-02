resource "aws_flow_log" "tier_vpc_flow_logs" {
  vpc_id               = var.new_vpc
  traffic_type         = var.traffic_type
  log_destination      = var.tier_vpc_cloudwatch_arn
  iam_role_arn         = var.vpc_flow_logs_iam_role_arn

  tags = {
    Name = "tier_vpc_flow_logs"
  }
}