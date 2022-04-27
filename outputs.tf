output "aws_sgp_shared01_instance_id" {
  description = "AWS Singapore Shared Services 01 Instance"
  value       = module.aws_sgp_shared01_instance.aws_instance.id
}

output "aws_sgp_shared01_instance_private_ip" {
  description = "AWS Singapore Shared Services 01 Instance Private IP"
  value       = module.aws_sgp_shared01_instance.aws_instance.private_ip
}

output "aws_sgp_shared01_ssm_session" {
  description = "AWS Singapore Shared Services 01 Instance SSM command"
  value       = "aws ssm start-session --region ${data.aws_region.current.name} --target ${module.aws_sgp_shared01_instance.aws_instance.id}"
}

output "aws_sgp_prod01_instance_id" {
  description = "AWS Singapore Production 01 Instance"
  value       = module.aws_sgp_prod01_instance.aws_instance.id
}

output "aws_sgp_prod01_instance_private_ip" {
  description = "AWS Singapore Production 01 Instance Private IP"
  value       = module.aws_sgp_prod01_instance.aws_instance.private_ip
}

output "aws_sgp_prod01_ssm_session" {
  description = "AWS Singapore Production 01 Instance SSM command"
  value       = "aws ssm start-session --region ${data.aws_region.current.name} --target ${module.aws_sgp_prod01_instance.aws_instance.id}"
}