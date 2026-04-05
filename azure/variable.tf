
variable "client_secret" {
  description = "Azure service principal client secret"
  type        = string
  sensitive   = true
  default     = "Enter your secret details"
}

variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
  sensitive   = true
  default     = "Enter your sub details details"
}

variable "client_id" {
  description = "Azure service principal client ID"
  type        = string
  sensitive   = true
  default     = "Enter your client details"
}

variable "tenant_id" {
  description = "Azure tenant ID"
  type        = string
  sensitive   = true
  default     = "Enter your details"
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
  type        = string
  default     = "IPsec"
}

variable "local_networks_ipsec_policy" {
  description = <<-EOT
    IPSec policy for local networks. Only a single policy can be defined for a connection.
    Attributes:
      dh_group         - DH group used in IKE phase 1. Valid values: DHGroup1, DHGroup2, DHGroup14, DHGroup24, DHGroup2048, ECP256, ECP384, None.
      ike_encryption   - IKE encryption algorithm. Valid values: AES128, AES192, AES256, DES, DES3, GCMAES128, GCMAES256.
      ike_integrity    - IKE integrity algorithm. Valid values: GCMAES128, GCMAES256, MD5, SHA1, SHA256, SHA384.
      ipsec_encryption - IPSec encryption algorithm. Valid values: AES128, AES192, AES256, DES, DES3, GCMAES128, GCMAES192, GCMAES256, None.
      ipsec_integrity  - IPSec integrity algorithm. Valid values: GCMAES128, GCMAES192, GCMAES256, MD5, SHA1, SHA256.
      pfs_group        - PFS group used in IKE phase 2. Valid values: ECP256, ECP384, None, PFS1, PFS2, PFS2048, PFS24, PFSMM.
      sa_datasize      - (Optional) IPSec SA payload size in KB. Must be between 1024 and 2147483647.
      sa_lifetime      - (Optional) IPSec SA lifetime in seconds. Must be between 300 and 172799.
  EOT
  type = object({
    dh_group         = string
    ike_encryption   = string
    ike_integrity    = string
    ipsec_encryption = string
    ipsec_integrity  = string
    pfs_group        = string
    sa_datasize      = optional(number)
    sa_lifetime      = optional(number)
  })
  default = null
}

variable "vpn_gw_sku" {
  description = "Configuration of the size and capacity of the virtual network gateway. Valid options are Basic, VpnGw1, VpnGw2, VpnGw3, VpnGw4,VpnGw5, VpnGw1AZ, VpnGw2AZ, VpnGw3AZ,VpnGw4AZ and VpnGw5AZ and depend on the type, vpn_type and generation arguments"
  type        = string
  default     = "VpnGw1"
}

variable "express_route_circuit_id" {
  description = "The ID of the Express Route Circuit when creating an ExpressRoute connection"
  type        = string
  default     = null
}

variable "peer_virtual_network_gateway_id" {
  description = "The ID of the peer virtual network gateway when creating a VNet-to-VNet connection"
  type        = string
  default     = null
}

variable "gateway_connection_protocol" {
  description = "The IKE protocol version to use. Possible values are IKEv1 and IKEv2. Defaults to IKEv2"
  type        = string
  default     = "IKEv2"
}

