resource "aws_iam_role" "system_manager_role" {
  name = "ssm-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "system_manager_policy" {
  role       = aws_iam_role.system_manager_role.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "system_manager_instance_profile" {
  name = "system_manager-instance-profile"
  role       = aws_iam_role.system_manager_role.id
}