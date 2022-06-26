resource "aws_vpc" "vpc" { #Sample VPC for demo purposes. Feel free to use yours if you already have a one. 
  cidr_block = "10.0.0.0/16"
}

resource "aws_vpn_gateway" "vpn_gateway" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_customer_gateway" "customer_gateway" {
  count      = 2
  bgp_asn    = 65515 #Azure virtual network gateway default ASN
  ip_address = var.public_ip_address_gw[count.index]
  type       = "ipsec.1"

  tags = {
    Name = "aws-azure-customer-gateway-${count.index}"
  }
}

resource "aws_vpn_connection" "main" {
  count                 = 2
  vpn_gateway_id        = aws_vpn_gateway.vpn_gateway.id
  customer_gateway_id   = aws_customer_gateway.customer_gateway[count.index].id
  type                  = "ipsec.1"
  static_routes_only    = false
  tunnel1_inside_cidr   = var.tunnel1_inside_cidr[count.index]
  tunnel2_inside_cidr   = var.tunnel2_inside_cidr[count.index]
  tunnel1_preshared_key = var.tunnel1_preshared_key[count.index]
  tunnel2_preshared_key = var.tunnel2_preshared_key[count.index]
}
