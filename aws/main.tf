resource "aws_vpc" "vpc" { #Sample VPC for demo purposes. Feel free to use yours if you already have a one. 
  cidr_block = "10.0.0.0/16"
}

resource "aws_vpn_gateway" "vpn_gateway" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_customer_gateway" "customer_gateway" {
  #for_each = toset({ for t in var.tunnel_config : t.public_ip_address_gw => t })
  for_each = var.tunnel_config

  bgp_asn    = 65515 #Azure virtual network gateway default ASN
  ip_address = each.value.public_ip_address_gw
  type       = "ipsec.1"

  tags = {
    Name      = "aws-azure-customer-gateway"
    IpAddress = each.value
  }
}

resource "aws_vpn_connection" "main" {
  #for_each = toset({ for t in var.tunnel_config : t.public_ip_address_gw => t })
  for_each = var.tunnel_config

  vpn_gateway_id        = aws_vpn_gateway.vpn_gateway.id
  customer_gateway_id   = aws_customer_gateway.customer_gateway[each.key].id
  type                  = "ipsec.1"
  static_routes_only    = false
  tunnel1_inside_cidr   = each.value.tunnel1_inside_cidr
  tunnel2_inside_cidr   = each.value.tunnel2_inside_cidr
  tunnel1_preshared_key = each.value.tunnel1_preshared_key
  tunnel2_preshared_key = each.value.tunnel2_preshared_key
}
