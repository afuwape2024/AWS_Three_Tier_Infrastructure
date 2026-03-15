#create web server ec2 
resource "aws_instance" "web_server" {
  count = 1
  ami     = var.ami
  instance_type = var.instance_type
  subnet_id                   = var.web_subnet
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.web-security_group]
  user_data = file("${path.module}/jenkins.sh")

  tags = var.mandatory_tags

}
