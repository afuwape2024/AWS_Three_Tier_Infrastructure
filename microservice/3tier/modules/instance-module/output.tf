output "web_server" {
  value = aws_instance.web_server[*].id
}