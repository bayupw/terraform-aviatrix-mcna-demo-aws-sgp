module "onprem" {
  source = "github.com/gleyfer/aviatrix-demo-onprem-aws"

  hostname            = "OnPrem"
  tunnel_proto        = "IPsec"
  network_cidr        = "192.168.0.0/16"
  public_subnets      = ["192.168.1.0/24"]
  private_subnets     = ["192.168.2.0/24"]
  instance_type       = "t3.medium"
  public_conns        = ["${module.aws_sgp_transit01.transit_gateway.gw_name}:${module.aws_sgp_transit01.transit_gateway.local_as_number}:1"]
  csr_bgp_as_num      = 65000
  create_client       = true
  advertised_prefixes = ["0.0.0.0/0"]
  key_name            = "ec2_keypair"

  depends_on = [module.aws_sgp_transit01]
}