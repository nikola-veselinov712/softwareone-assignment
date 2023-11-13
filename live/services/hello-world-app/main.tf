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
    key            = "services/hello-world-app/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "nveselinov-dynamodb-softwareone-assessment"
    encrypt        = true
  }
}

provider "aws" {
  region = "eu-west-1"
}


module "hello_world_app" {

  source = "../../../modules/services/hello-world-app"

  server_text = var.server_text

  environment                    = var.environment
  db_remote_state_bucket         = var.db_remote_state_bucket
  db_remote_state_key            = var.db_remote_state_key
  db_remote_state_bucket_network = var.db_remote_state_bucket_network
  db_remote_state_key_network    = var.db_remote_state_key_network

  instance_type      = "t2.micro"
  min_size           = 2
  max_size           = 2
  enable_autoscaling = true
  ami                = data.aws_ami.ubuntu.id
  vpc_id             = data.terraform_remote_state.network.outputs.vpc_id
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "nveselinov-s3-bucket-softwareone-assessment"
    key = "network/terraform.tfstate"
    region = "eu-west-1"
  }
}