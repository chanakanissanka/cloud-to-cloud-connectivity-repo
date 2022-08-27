
variable "client_secret" {
  default = "Enter your secret details"
}

variable "subscription_id" {
  default = "Enter your sub details details"
}

variable "client_id" {
  default = "Enter your client details"
}

variable "tenant_id" {
  default = "Enter your details"
}

variable "local_networks" {
  type = list(object({
    local_address_space   = list(string)
    local_gateway_address = string
    local_gw_name         = string
    shared_key            = string
    asn_number            = number
    peer_weight           = number
    peering_address       = string
  }))
  default = [
    {
      local_address_space   = ["10.10.0.0/20"]
      local_gateway_address = "87.54.43.24" #This is just a fake value for demo purpose. you need to download from AWS VPN config and find the corresponding IP
      local_gw_name         = "To-AWS-1"
      shared_key            = "fgdytdgdstsgshasgsgsashh" #Refferece to Key Vault is recommeded here. 
      asn_number            = 64512
      peer_weight           = 0
      peering_address       = "169.254.21.1"
    },
    {
      local_address_space   = ["10.10.0.0/20"] #
      local_gateway_address = "87.54.43.25"    #This is just a fake value for demo purpose. you need to download from AWS VPN config and find the corresponding IP
      local_gw_name         = "To-AWS-2"
      shared_key            = "fgdytdgdstsgshasgsgsashh"
      asn_number            = 64512
      peer_weight           = 0
      peering_address       = "169.254.21.5"
    },
    {
      local_address_space   = ["10.10.0.0/20"]
      local_gateway_address = "87.54.43.26" #This is just a fake value for demo purpose. you need to download from AWS VPN config and find the corresponding IP
      local_gw_name         = "To-AWS-3"
      shared_key            = "fgdytdgdstsgshasgsgsashh"
      asn_number            = 64512
      peer_weight           = 0
      peering_address       = "169.254.21.29"
    },
    {
      local_address_space   = ["10.10.0.0/20"]
      local_gateway_address = "87.54.43.27" #This is just a fake value for demo purpose. you need to download from AWS VPN config and find the corresponding IP
      local_gw_name         = "To-AWS-4"
      shared_key            = "fgdytdgdstsgshasgsgsashh"
      asn_number            = 64512
      peer_weight           = 0
      peering_address       = "169.254.21.33"
    }
  ]
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

