data "aws_region" "current" {}

#################
# AWS Singapore #
#################

module "aws_sgp_transit01" {
  source  = "terraform-aviatrix-modules/mc-transit/aviatrix"
  version = "2.0.1"

  name                   = "aws-sgp-transit01"
  cloud                  = "aws"
  region                 = data.aws_region.current.name
  cidr                   = cidrsubnet(var.supernet, 7, 0)
  account                = "aws-account"
  ha_gw                  = false
  instance_size          = "t2.micro"
  single_az_ha           = false
  enable_segmentation    = true
  enable_transit_firenet = false

  local_as_number             = 65002
  learned_cidr_approval       = true
  learned_cidrs_approval_mode = "gateway"
}

module "aws_sgp_spoke_shared01" {
  source  = "terraform-aviatrix-modules/mc-spoke/aviatrix"
  version = "1.1.2"

  name          = "aws-sgp-spoke-shared01"
  cloud         = "AWS"
  cidr          = cidrsubnet(var.supernet, 8, 11)
  region        = data.aws_region.current.name
  account       = "aws-account"
  instance_size = "t2.micro"
  single_az_ha  = false
  ha_gw         = false
  attached      = false
  #transit_gw = module.aws_sgp_transit01.transit_gateway.gw_name
}

module "aws_sgp_spoke_prod01" {
  source  = "terraform-aviatrix-modules/mc-spoke/aviatrix"
  version = "1.1.2"

  name          = "aws-sgp-spoke-prod01"
  cloud         = "AWS"
  cidr          = cidrsubnet(var.supernet, 8, 12)
  region        = data.aws_region.current.name
  account       = "aws-account"
  instance_size = "t2.micro"
  single_az_ha  = false
  ha_gw         = false
  attached      = false
  #transit_gw = module.aws_sgp_transit01.transit_gateway.gw_name
}

#############
# Instances #
#############

module "ssm_instance_profile" {
  source  = "bayupw/ssm-instance-profile/aws"
  version = "1.0.0"
}

module "aws_sgp_shared01_ssm" {
  source  = "bayupw/ssm-vpc-endpoint/aws"
  version = "1.0.1"

  vpc_id         = module.aws_sgp_spoke_shared01.vpc.vpc_id
  vpc_subnet_ids = [module.aws_sgp_spoke_shared01.vpc.private_subnets[0].subnet_id]

  depends_on = [module.aws_sgp_spoke_shared01]
}

module "aws_sgp_shared01_instance" {
  source  = "bayupw/amazon-linux-2/aws"
  version = "1.0.0"

  instance_hostname    = "sgp-shared01-instance"
  vpc_id               = module.aws_sgp_spoke_shared01.vpc.vpc_id
  subnet_id            = module.aws_sgp_spoke_shared01.vpc.private_subnets[0].subnet_id
  key_name             = "ec2_keypair"
  iam_instance_profile = module.ssm_instance_profile.aws_iam_instance_profile

  associate_public_ip_address    = false
  enable_password_authentication = true
  random_password                = false
  instance_username              = var.instance_username
  instance_password              = var.instance_password

  depends_on = [module.aws_sgp_spoke_shared01]
}

module "aws_sgp_prod01_ssm" {
  source  = "bayupw/ssm-vpc-endpoint/aws"
  version = "1.0.1"

  vpc_id         = module.aws_sgp_spoke_prod01.vpc.vpc_id
  vpc_subnet_ids = [module.aws_sgp_spoke_prod01.vpc.private_subnets[0].subnet_id]

  depends_on = [module.aws_sgp_spoke_prod01]
}

module "aws_sgp_prod01_instance" {
  source  = "bayupw/amazon-linux-2/aws"
  version = "1.0.0"

  instance_hostname    = "sgp-prod01-instance"
  vpc_id               = module.aws_sgp_spoke_prod01.vpc.vpc_id
  subnet_id            = module.aws_sgp_spoke_prod01.vpc.private_subnets[0].subnet_id
  key_name             = "ec2_keypair"
  iam_instance_profile = module.ssm_instance_profile.aws_iam_instance_profile

  associate_public_ip_address    = false
  enable_password_authentication = true
  random_password                = false
  instance_username              = var.instance_username
  instance_password              = var.instance_password

  depends_on = [module.aws_sgp_spoke_prod01]
}
