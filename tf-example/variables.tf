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
  description = "Information for multiple disks"
  default = null
}

variable "aws_subnet" {
  type        = string
  description = "subnet id"
}

variable "aws_security_group" {
  type        = string
  description = "security group id"
}

variable "aws_family" {
  type        = string
  description = "family type to build the ec2 instance"
}

variable "aws_region" {
  type        = string
  description = "AWS Region"
}

variable "instance1" {
  type        = string
  description = "Hostname instance"
}

variable "users_list" {
  type        = string
  description = "Users list for access management"
  default     = "ansible"
}

variable "login_approle_role_id" {
  type = string
  description = "vault approle id"
}

variable "login_approle_secret_id" {
  type = string
  description = "vault approle secret id"
}
