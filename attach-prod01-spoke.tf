# Attach AWS Singapore Production Spoke to AWS Singapore Transit 01

resource "aviatrix_spoke_transit_attachment" "aws_sgp_prod01_to_transit01" {
  spoke_gw_name   = module.aws_sgp_spoke_prod01.spoke_gateway.gw_name
  transit_gw_name = module.aws_sgp_transit01.transit_gateway.gw_name

  depends_on = [module.aws_sgp_transit01, module.aws_sgp_spoke_prod01]
}