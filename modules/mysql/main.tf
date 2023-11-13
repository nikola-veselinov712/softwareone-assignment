terraform {
  required_version = ">= 1.0.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

resource "aws_db_instance" "example" {
  identifier_prefix   = var.identifier_prefix
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  db_name             = var.db_name
  username            = var.db_username
  password            = var.db_password
  skip_final_snapshot = true
  db_subnet_group_name = var.db_subnet_group_name
  vpc_security_group_ids = [resource.aws_security_group.db1.id, resource.aws_security_group.db2.id]
}

resource "aws_security_group" "db1" {
  name = "ec2-rds-1"
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "allow_mysql_inbound1" {
  type              = "ingress"
  security_group_id = aws_security_group.db1.id

  from_port   = local.mysql_port
  to_port     = local.mysql_port
  protocol    = local.tcp_protocol
  cidr_blocks = [data.terraform_remote_state.network.outputs.private_subnets_cidr_blocks[0]]
}

resource "aws_security_group_rule" "allow_all_outbound1" {
  type              = "egress"
  security_group_id = aws_security_group.db1.id

  from_port   = local.any_port
  to_port     = local.any_port
  protocol    = local.any_protocol
  cidr_blocks = local.all_ips
}

resource "aws_security_group" "db2" {
  name = "ec2-rds-2"
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "allow_mysql_inbound2" {
  type              = "ingress"
  security_group_id = aws_security_group.db2.id

  from_port   = local.mysql_port
  to_port     = local.mysql_port
  protocol    = local.tcp_protocol
  cidr_blocks = [data.terraform_remote_state.network.outputs.private_subnets_cidr_blocks[1]]
}

resource "aws_security_group_rule" "allow_all_outbound2" {
  type              = "egress"
  security_group_id = aws_security_group.db2.id

  from_port   = local.any_port
  to_port     = local.any_port
  protocol    = local.any_protocol
  cidr_blocks = local.all_ips
}

locals {
  mysql_port    = 3306
  any_port     = 0
  any_protocol = "-1"
  tcp_protocol = "tcp"
  all_ips      = ["0.0.0.0/0"]
}

data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket = var.db_remote_state_bucket_network
    key    = var.db_remote_state_key_network
    region = "eu-west-1"
  }
}