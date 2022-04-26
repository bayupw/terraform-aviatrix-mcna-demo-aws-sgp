output "aws_sgp_prod02_instance_id" {
  description = "AWS Singapore Prod02 Instance"
  value       = module.aws_sgp_prod02_instance.aws_instance.id
  sensitive   = false
}

output "aws_sgp_prod02_ssm_session" {
  description = "AWS Singapore Prod02 Instance"
  value       = "aws ssm start-session --region ${data.aws_region.current.name} --target ${module.aws_sgp_prod02_instance.aws_instance.id}"
  sensitive   = false
}

output "aws_sgp_dev01_instance_id" {
  description = "AWS Singapore Dev01 Instance"
  value       = module.aws_sgp_dev01_instance.aws_instance.id
  sensitive   = false
}

output "aws_sgp_dev01_ssm_session" {
  description = "AWS Singapore Dev01 Instance"
  value       = "aws ssm start-session --region ${data.aws_region.current.name} --target ${module.aws_sgp_dev01_instance.aws_instance.id}"
  sensitive   = false
}