variable "load_balancer_security_group" {}

variable "new_vpc" {
  type = string
}

variable "app_subnet_ids" {
  type = list(string)
}

variable "app_target_group" {
  type    = string
  default = "web-target-group"
}