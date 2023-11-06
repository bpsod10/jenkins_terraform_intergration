provider "aws" {
  region = "us-east-1"
}

  backend "s3" {
    bucket         = "ed-eos-terraform-state-bod2"
    region         = "us-east-1"
    key            = "dev/state/terraform.tfstate"
    dynamodb_table = "eos_table2"
  }

resource "aws_instance" "example" {
    ami = "ami-0fc5d935ebf8bc3bc"
    instance_type = "t2.micro"
    }
