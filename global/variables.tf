variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default     = "nveselinov-s3-bucket-softwareone-assessment"
}

variable "table_name" {
  description = "The name of the DynamoDB table"
  type        = string
  default     = "nveselinov-dynamodb-softwareone-assessment"
}