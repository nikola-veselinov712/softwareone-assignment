terraform {
  required_version = ">= 1.0.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "nveselinov-s3-bucket-softwareone-assessment"
    key            = "network/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "nveselinov-dynamodb-softwareone-assessment"
    encrypt        = true
  }
}

################################################################################
# VPC Module
################################################################################

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs              = ["eu-west-1a", "eu-west-1b"]
  private_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets   = ["10.0.101.0/24", "10.0.102.0/24"]
  database_subnets = ["10.0.21.0/24", "10.0.22.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = false
  one_nat_gateway_per_az = false

  reuse_nat_ips = true
  external_nat_ip_ids = resource.aws_eip.nat.*.id


  tags = {
    Terraform = "true"
  }
}

resource "aws_eip" "nat" {
  count = 4
  domain = "vpc"
}