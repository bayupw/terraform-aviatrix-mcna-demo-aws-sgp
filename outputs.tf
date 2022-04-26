output "aws_sgp_prod02_instance" {
  description = "AWS SGP Prod02 Instance"
  value       = module.aws_sgp_prod02_instance.aws_instance
  sensitive   = false
}

output "aws_sgp_prod02_instance_password" {
  description = "AWS SGP Prod02 Instance Password"
  value       = module.aws_sgp_prod02_instance.local.instance_password
  sensitive   = true
}

output "aws_sgp_dev01_instance" {
  description = "AWS SGP Dev01 Instance"
  value       = module.aws_sgp_dev01_instance.aws_instance
  sensitive   = false
}

output "aws_sgp_dev01_instance_password" {
  description = "AWS SGP Dev01 Instance Password"
  value       = module.aws_sgp_dev01_instance.local.instance_password
  sensitive   = true
}