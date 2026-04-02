output "system_manager_role" {
  description = "IAM role name used for system manager"
  value       = aws_iam_role.system_manager_role.id
}

output "system_manager_instance_profile" 
 {
  value       = aws_iam_instance_profile.system_manager_instance_profile.id
}
