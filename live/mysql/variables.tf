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

variable "db_remote_state_bucket_network" {
  description = "The name of the S3 bucket used for the network's remote state storage"
  type        = string
  default     = "nveselinov-s3-bucket-softwareone-assessment"
}

variable "db_remote_state_key_network" {
  description = "The name of the key in the S3 bucket used for the network's remote state storage"
  type        = string
  default     = "network/terraform.tfstate"
}

variable "db_name" {
  description = "The name to use for the database"
  type        = string
  default     = "nikolaRDS"
}
