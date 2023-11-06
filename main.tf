terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.22.0"
    }
  }
  backend "s3" {
    bucket         = "ed-eos-terraform-state-bod2"
    region         = "us-east-1"
    key            = "dev/state/terraform.tfstate"
    dynamodb_table = "eos_table2"
  }
}

provider "aws" {
  region  = "us-east-1"
}
