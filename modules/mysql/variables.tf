variable "db_name" {
  description = "The name to use for the database"
  type        = string
}

variable "db_username" {
  description = "The username for the database"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "The password for the database"
  type        = string
  sensitive   = true
}

variable "identifier_prefix" {
  description = "The identifier_prefix to use for the database"
  type        = string
}

variable "db_remote_state_bucket_network" {
  description = "The name of the S3 bucket used for the network's remote state storage"
  type        = string
}

variable "db_remote_state_key_network" {
  description = "The name of the key in the S3 bucket used for the network's remote state storage"
  type        = string
}

variable "db_subnet_group_name" {
  description = "The name of the db subnet group name"
  type        = string
}

variable "vpc_id" {
  description = "The VPC to deploy to"
}
