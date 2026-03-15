# Policies Attached
#  AmazonEKSWorkerNodePolicy
#  AmazonEKS_CNI_Policy
#  AmazonEC2ContainerRegistryPullOnly


data "aws_ami" "delete_ec2_eks" {
  most_recent      = true
  owners           = ["amazon"]

  filter {
    name   = "name"
    values = ["arn:aws:iam::127996279847:role/delete_ec2_eks"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
