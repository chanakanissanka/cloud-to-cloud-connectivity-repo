<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.18.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_local_network_gateway.localgw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/local_network_gateway) | resource |
| [azurerm_public_ip.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_subnet.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_network.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_virtual_network_gateway.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_gateway) | resource |
| [azurerm_virtual_network_gateway_connection.az-hub-onprem](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_gateway_connection) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_client_id"></a> [client\_id](#input\_client\_id) | n/a | `string` | `"Enter your client details"` | no |
| <a name="input_client_secret"></a> [client\_secret](#input\_client\_secret) | n/a | `string` | `"Enter your secret details"` | no |
| <a name="input_express_route_circuit_id"></a> [express\_route\_circuit\_id](#input\_express\_route\_circuit\_id) | The ID of the Express Route Circuit when creating an ExpressRoute connection | `any` | `null` | no |
| <a name="input_gateway_connection_protocol"></a> [gateway\_connection\_protocol](#input\_gateway\_connection\_protocol) | The IKE protocol version to use. Possible values are IKEv1 and IKEv2. Defaults to IKEv2 | `string` | `"IKEv2"` | no |
| <a name="input_gateway_connection_type"></a> [gateway\_connection\_type](#input\_gateway\_connection\_type) | The type of connection. Valid options are IPsec (Site-to-Site), ExpressRoute (ExpressRoute), and Vnet2Vnet (VNet-to-VNet) | `string` | `"IPsec"` | no |
| <a name="input_local_networks"></a> [local\_networks](#input\_local\_networks) | n/a | <pre>list(object({<br>    local_address_space   = list(string)<br>    local_gateway_address = string<br>    local_gw_name         = string<br>    shared_key            = string<br>    asn_number            = number<br>    peer_weight           = number<br>    peering_address       = string<br>  }))</pre> | <pre>[<br>  {<br>    "asn_number": 64512,<br>    "local_address_space": [<br>      "10.10.0.0/20"<br>    ],<br>    "local_gateway_address": "87.54.43.24",<br>    "local_gw_name": "To-AWS-1",<br>    "peer_weight": 0,<br>    "peering_address": "169.254.21.1",<br>    "shared_key": "fgdytdgdstsgshasgsgsashh"<br>  },<br>  {<br>    "asn_number": 64512,<br>    "local_address_space": [<br>      "10.10.0.0/20"<br>    ],<br>    "local_gateway_address": "87.54.43.25",<br>    "local_gw_name": "To-AWS-2",<br>    "peer_weight": 0,<br>    "peering_address": "169.254.21.5",<br>    "shared_key": "fgdytdgdstsgshasgsgsashh"<br>  },<br>  {<br>    "asn_number": 64512,<br>    "local_address_space": [<br>      "10.10.0.0/20"<br>    ],<br>    "local_gateway_address": "87.54.43.26",<br>    "local_gw_name": "To-AWS-3",<br>    "peer_weight": 0,<br>    "peering_address": "169.254.21.29",<br>    "shared_key": "fgdytdgdstsgshasgsgsashh"<br>  },<br>  {<br>    "asn_number": 64512,<br>    "local_address_space": [<br>      "10.10.0.0/20"<br>    ],<br>    "local_gateway_address": "87.54.43.27",<br>    "local_gw_name": "To-AWS-4",<br>    "peer_weight": 0,<br>    "peering_address": "169.254.21.33",<br>    "shared_key": "fgdytdgdstsgshasgsgsashh"<br>  }<br>]</pre> | no |
| <a name="input_local_networks_ipsec_policy"></a> [local\_networks\_ipsec\_policy](#input\_local\_networks\_ipsec\_policy) | IPSec policy for local networks. Only a single policy can be defined for a connection. | `any` | `null` | no |
| <a name="input_peer_virtual_network_gateway_id"></a> [peer\_virtual\_network\_gateway\_id](#input\_peer\_virtual\_network\_gateway\_id) | The ID of the peer virtual network gateway when creating a VNet-to-VNet connection | `any` | `null` | no |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | n/a | `string` | `"Enter your sub details details"` | no |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | n/a | `string` | `"Enter your details"` | no |
| <a name="input_vpn_gw_sku"></a> [vpn\_gw\_sku](#input\_vpn\_gw\_sku) | Configuration of the size and capacity of the virtual network gateway. Valid options are Basic, VpnGw1, VpnGw2, VpnGw3, VpnGw4,VpnGw5, VpnGw1AZ, VpnGw2AZ, VpnGw3AZ,VpnGw4AZ and VpnGw5AZ and depend on the type, vpn\_type and generation arguments | `string` | `"VpnGw1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_public_ip_address_gw"></a> [public\_ip\_address\_gw](#output\_public\_ip\_address\_gw) | n/a |
<!-- END_TF_DOCS -->