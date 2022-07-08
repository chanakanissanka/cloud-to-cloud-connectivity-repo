resource "azurerm_resource_group" "this" {
  name     = "cloud-test"
  location = "Australia East"
}

resource "azurerm_virtual_network" "this" {
  name                = "cloud-test"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = ["10.200.0.0/16"]
}

resource "azurerm_subnet" "this" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.200.1.0/24"]
}

resource "azurerm_public_ip" "this" {
  count               = 2
  name                = "test_PIP-${count.index}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  allocation_method   = "Dynamic"
}

resource "azurerm_virtual_network_gateway" "this" {
  name                = "test"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = true
  enable_bgp    = true
  sku           = var.vpn_gw_sku

  dynamic "ip_configuration" {
    for_each = azurerm_public_ip.this
    iterator = ip

    content {
      name                          = "vnetGatewayConfig-${ip.key + 1}"
      public_ip_address_id          = ip.value.id
      private_ip_address_allocation = "Dynamic"
      subnet_id                     = azurerm_subnet.this.id
    }
  }
}

#---------------------------
# Local Network Gateway
#---------------------------
resource "azurerm_local_network_gateway" "localgw" {
  for_each = toset({ for t in var.local_networks : t.local_gw_name => t })

  name                = "localgw-${each.key}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  gateway_address     = each.value.local_gateway_address
  address_space       = each.value.local_address_space

  bgp_settings {
    asn                 = each.value.asn_number
    bgp_peering_address = each.value.peering_address
    peer_weight         = each.value.peer_weight
  }
}

#---------------------------------------
# Virtual Network Gateway Connection
#---------------------------------------
resource "azurerm_virtual_network_gateway_connection" "az-hub-onprem" {
  for_each = toset({ for t in var.local_networks : t.local_gw_name => t })

  name                       = "lgw-connection-${each.value.local_gw_name}"
  location                   = azurerm_resource_group.this.location
  resource_group_name        = azurerm_resource_group.this.name
  type                       = var.gateway_connection_type
  virtual_network_gateway_id = azurerm_virtual_network_gateway.this.id
  local_network_gateway_id   = azurerm_local_network_gateway.localgw[each.key].id
  connection_protocol        = var.gateway_connection_protocol
  enable_bgp                 = true

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
