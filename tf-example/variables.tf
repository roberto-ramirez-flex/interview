## 
locals {
  vault_server            = "https://prod.example.com:8200/"
  vault_namespace         = "namespace"
  vault_mount             = "kv2"
  vault_secret            = "terraform"
  user_data_tpl           = "./bootstrap.tpl"
  disk_type               = "gp3"
  createddate             = timestamp()
  disk_size_gb            = "128"
}

variable "disk_info" {
  type        = list(any)
  default = null
}

variable "aws_subnet" {
  type        = string
}

variable "aws_security_group" {
  type        = string
}

variable "aws_family" {
  type        = string
}

variable "aws_region" {
  type        = string
}

variable "instance1" {
  type        = string
}

variable "users_list" {
  type        = string
  default     = "ansible"
}

variable "login_approle_role_id" {
  type = string
}

variable "login_approle_secret_id" {
  type = string
}
