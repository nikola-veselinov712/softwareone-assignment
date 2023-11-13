output "address" {
  value       = aws_db_instance.example.address
  description = "Connect to the database at this endpoint"
}

output "port" {
  value       = aws_db_instance.example.port
  description = "The port the database is listening on"
}

output "id" {
  value       = aws_db_instance.example.id
  description = "The ID of the database"
}

output "instance_class" {
  value       = aws_db_instance.example.instance_class
  description = "The instance class of the database"
}