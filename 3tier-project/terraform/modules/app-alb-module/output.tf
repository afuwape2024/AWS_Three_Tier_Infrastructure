output "internal_application_load_balancer_sg" {
    value = aws_security_group.internal_application_load_balancer_sg.id
}
output "internal_target_group" {
    value = aws_lb_target_group.internal_target_group.arn
}
output "internal_application_lb"{
    value = aws_lb.internal_application_lb.id
}
output "internal_application_arn"{
    value = aws_lb.internal_application_lb.arn
}

output "internal_listener" {
    value = aws_lb_listener.internal_listener.id
}

