resource "aws_iam_role" "iam_role_vpc_flow_log" {
  name = "iam_role_vpc_flow_log"

###creating the iam role for the VPC flow logs
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "vpc-flow-logs.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "iam_role_vpc_flow_log"
  }
}

resource "aws_iam_role_policy" "iam_role_vpc_flow_log_policy" {
  name = "iam_role_vpc_flow_log_policy"
  role = aws_iam_role.iam_role_vpc_flow_log.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "PublishFlowLogsToCloudWatch"
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams"
        ]
        Resource = "*"
      }
    ]
  })
}