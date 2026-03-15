variable "vpc_id" {
	type = string
}

variable "ami" {
  default = "ami-06e3c045d79fd65d9"
}
variable "instance_type" {
  default = "t3.micro"
}
variable "web-security_group" {}

variable "web_subnet" {
  description = "Public subnet ID for EC2 instances"
}

variable "mandatory_tags" {
  type = map(string)
  default = {
    Environment = "dev"
    Project     = "3-tier-microservice"
  }
}