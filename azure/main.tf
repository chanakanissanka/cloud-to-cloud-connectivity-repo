resource "azurerm_resource_group" "example" {
  name     = "test"
  location = "Australia East"
}

resource "azurerm_virtual_network" "example" {
  name                = "test"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "example" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "example" {
  count               = 2
  name                = "test_PIP-${count.index}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  allocation_method = "Dynamic"
}

resource "azurerm_virtual_network_gateway" "example" {
  name                = "test"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = true
  enable_bgp    = true
  sku           = var.vpn_gw_sku

  dynamic "ip_configuration" {
    for_each = azurerm_public_ip.example
    iterator = ip

    content {

      name                          = "vnetGatewayConfig-${ip.key + 1}"
      public_ip_address_id          = ip.value.id
      private_ip_address_allocation = "Dynamic"
      subnet_id                     = azurerm_subnet.example.id
    }
  }


}


#---------------------------
# Local Network Gateway
#---------------------------
resource "azurerm_local_network_gateway" "localgw" {
  count               = length(var.local_networks)
  name                = "localgw-${var.local_networks[count.index].local_gw_name}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  gateway_address     = var.local_networks[count.index].local_gateway_address
  address_space       = var.local_networks[count.index].local_address_space

  dynamic "bgp_settings" {
    for_each = var.local_bgp_settings != null ? [true] : []
    content {
      asn                 = var.local_bgp_settings[count.index].asn_number
      bgp_peering_address = var.local_bgp_settings[count.index].peering_address
      peer_weight         = var.local_bgp_settings[count.index].peer_weight
    }
  }


}

#---------------------------------------
# Virtual Network Gateway Connection
#---------------------------------------
resource "azurerm_virtual_network_gateway_connection" "az-hub-onprem" {
  count                           = var.gateway_connection_type == "ExpressRoute" ? 1 : length(var.local_networks)
  name                            = var.gateway_connection_type == "ExpressRoute" ? "localgw-expressroute-connection" : "localgw-connection-${var.local_networks[count.index].local_gw_name}"
  location                        = azurerm_resource_group.example.location
  resource_group_name             = azurerm_resource_group.example.name
  type                            = var.gateway_connection_type
  virtual_network_gateway_id      = azurerm_virtual_network_gateway.example.id
  local_network_gateway_id        = var.gateway_connection_type != "ExpressRoute" ? azurerm_local_network_gateway.localgw[count.index].id : null
  express_route_circuit_id        = var.gateway_connection_type == "ExpressRoute" ? var.express_route_circuit_id : null
  peer_virtual_network_gateway_id = var.gateway_connection_type == "Vnet2Vnet" ? var.peer_virtual_network_gateway_id : null
  shared_key                      = var.gateway_connection_type != "ExpressRoute" ? var.local_networks[count.index].shared_key : null
  connection_protocol             = var.gateway_connection_type == "IPSec" && var.vpn_gw_sku == ["VpnGw1", "VpnGw2", "VpnGw3", "VpnGw1AZ", "VpnGw2AZ", "VpnGw3AZ"] ? var.gateway_connection_protocol : null

  dynamic "ipsec_policy" {
    for_each = var.local_networks_ipsec_policy != null ? [true] : []
    content {
      dh_group         = var.local_networks_ipsec_policy.dh_group
      ike_encryption   = var.local_networks_ipsec_policy.ike_encryption
      ike_integrity    = var.local_networks_ipsec_policy.ike_integrity
      ipsec_encryption = var.local_networks_ipsec_policy.ipsec_encryption
      ipsec_integrity  = var.local_networks_ipsec_policy.ipsec_integrity
      pfs_group        = var.local_networks_ipsec_policy.pfs_group
      sa_datasize      = var.local_networks_ipsec_policy.sa_datasize
      sa_lifetime      = var.local_networks_ipsec_policy.sa_lifetime
    }
  }

}
