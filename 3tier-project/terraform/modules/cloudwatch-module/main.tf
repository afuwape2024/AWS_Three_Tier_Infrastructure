resource "aws_cloudwatch_log_group" "tier_vpc_cloudwatch"{
  name = "3tier_vpc_cloudwatch"
  tags = {
    Name = "3tier_vpc_cloudwatch"
  }
}