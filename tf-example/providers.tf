## 
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.9.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "3.17.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region     = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
}


provider "vault" {
  address   = local.vault_server
  namespace = local.vault_namespace
  auth_login {
    path = "auth/approle/login"
    parameters = {
      role_id   = var.login_approle_role_id
      secret_id = var.login_approle_secret_id
    }
  }
}
