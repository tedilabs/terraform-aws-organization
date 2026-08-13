terraform {
  required_version = ">= 1.12"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.54"
    }
    awscc = {
      source  = "hashicorp/awscc"
      version = ">= 1.85"
    }
  }
}
