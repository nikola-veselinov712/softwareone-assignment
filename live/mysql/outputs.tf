output "address" {
  value       = module.mysql.address
  description = "Connect to the database at this endpoint"
}

output "port" {
  value       = module.mysql.port
  description = "The port the database is listening on"
}

output "id" {
  value       = module.mysql.id
  description = "The ID of the database"
}

output "instance_class" {
  value       = module.mysql.instance_class
  description = "The instance class of the database"
}