
variable "client_secret" {
  default = "QUoUbm2-Lp7uu0Q~apTKz1vu8V3g2lR47b"


}

variable "subscription_id" {
  default = "e4188303-99fe-4b9d-aa01-b98619fed585"


}

variable "client_id" {
  default = "f4e275f3-7da2-4cc3-bf58-6ff4cc3a28d2"


}

variable "tenant_id" {
  default = "d6248ab4-ffcf-44fc-9ee4-cf93fbfe5c54"


}

variable "local_networks" {
  type = list(object({ local_gw_name = string, local_gateway_address = string, local_address_space = list(string), shared_key = string }))
  default = [{
    local_address_space   = ["10.10.0.0/20"]
    local_gateway_address = "87.54.43.24"
    local_gw_name         = "To-AWS-1"
    shared_key            = "sdfresx"
    },
    {
      local_address_space   = ["10.10.0.0/20"]
      local_gateway_address = "87.54.43.25"
      local_gw_name         = "To-AWS-2"
      shared_key            = "sdfresx"
    },
    {
      local_address_space   = ["10.10.0.0/20"]
      local_gateway_address = "87.54.43.26"
      local_gw_name         = "To-AWS-3"
      shared_key            = "sdfresx"
    },
    {
      local_address_space   = ["10.10.0.0/20"]
      local_gateway_address = "87.54.43.27"
      local_gw_name         = "To-AWS-4"
      shared_key            = "sdfresx"
  }]


}


variable "local_bgp_settings" {
  type        = list(object({ asn_number = number, peering_address = string, peer_weight = number }))
  description = "Local Network Gateway's BGP speaker settings"
  default = [{
    asn_number      = 64512
    peer_weight     = 0
    peering_address = "169.254.21.1"
    },
    {
      asn_number      = 64512
      peer_weight     = 0
      peering_address = "169.254.21.5"
    },
    {
      asn_number      = 64512
      peer_weight     = 0
      peering_address = "169.254.21.29"
    },
    {
      asn_number      = 64512
      peer_weight     = 0
      peering_address = "169.254.21.33"
  }]
}

variable "gateway_connection_type" {
  description = "The type of connection. Valid options are IPsec (Site-to-Site), ExpressRoute (ExpressRoute), and Vnet2Vnet (VNet-to-VNet)"
  default     = "IPsec"
}

variable "local_networks_ipsec_policy" {
  description = "IPSec policy for local networks. Only a single policy can be defined for a connection."
  default     = null
}

variable "vpn_gw_sku" {
  description = "Configuration of the size and capacity of the virtual network gateway. Valid options are Basic, VpnGw1, VpnGw2, VpnGw3, VpnGw4,VpnGw5, VpnGw1AZ, VpnGw2AZ, VpnGw3AZ,VpnGw4AZ and VpnGw5AZ and depend on the type, vpn_type and generation arguments"
  default     = "VpnGw1"
}

variable "express_route_circuit_id" {
  description = "The ID of the Express Route Circuit when creating an ExpressRoute connection"
  default     = null
}

variable "peer_virtual_network_gateway_id" {
  description = "The ID of the peer virtual network gateway when creating a VNet-to-VNet connection"
  default     = null
}

variable "gateway_connection_protocol" {
  description = "The IKE protocol version to use. Possible values are IKEv1 and IKEv2. Defaults to IKEv2"
  default     = "IKEv2"
}
