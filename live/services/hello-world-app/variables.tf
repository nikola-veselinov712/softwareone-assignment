variable "db_remote_state_bucket" {
  description = "The name of the S3 bucket for the database's remote state"
  type        = string
  default     = "nveselinov-s3-bucket-softwareone-assessment"
}

variable "db_remote_state_key" {
  description = "The path for the database's remote state in S3"
  type        = string
  default     = "db/terraform.tfstate"
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

variable "server_text" {
  description = "The text the web server should return"
  default     = "Hello, World from $(hostname -f)"
  type        = string
}

variable "environment" {
  description = "The name of the environment we're deploying to"
  type        = string
  default     = "prod"
}