variable "log_group_name" {
  description = "Optional custom CloudWatch Log Group name"
  type        = string
  default     = null
}

variable "retention_in_days" {
  description = "CloudWatch log retention in days"
  type        = number
  default     = 5
}