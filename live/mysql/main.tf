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
    key            = "db/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "nveselinov-dynamodb-softwareone-assessment"
    encrypt        = true
  }
}

provider "aws" {
  region = "eu-west-1"
}

module "mysql" {
  source = "../../modules/mysql"
  
  identifier_prefix = "nikola-rds-db"
  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password
  db_remote_state_bucket_network = var.db_remote_state_bucket_network
  db_remote_state_key_network    = var.db_remote_state_key_network
  db_subnet_group_name = data.terraform_remote_state.network.outputs.database_subnet_group_name
  vpc_id = data.terraform_remote_state.network.outputs.vpc_id
}

data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket = var.db_remote_state_bucket_network
    key    = var.db_remote_state_key_network
    region = "eu-west-1"
  }
}

resource "aws_sns_topic" "default" {
  name_prefix = "nikolaSNStopicRDS"
}

module "aws-rds-alarms" {
  source         = "lorenzoaiello/rds-alarms/aws"
  db_instance_id = module.mysql.id
  actions_alarm  = [aws_sns_topic.default.arn]
  actions_ok     = [aws_sns_topic.default.arn]
  db_instance_class = module.mysql.instance_class
}