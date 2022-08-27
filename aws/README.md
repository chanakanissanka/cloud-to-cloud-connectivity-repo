<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.75.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_customer_gateway.customer_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/customer_gateway) | resource |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_vpn_connection.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpn_connection) | resource |
| [aws_vpn_gateway.vpn_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpn_gateway) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_tunnel_config"></a> [tunnel\_config](#input\_tunnel\_config) | n/a | <pre>list(object({<br>    public_ip_address_gw  = string<br>    tunnel1_inside_cidr   = string<br>    tunnel2_inside_cidr   = string<br>    tunnel1_preshared_key = string<br>    tunnel2_preshared_key = string<br>  }))</pre> | <pre>[<br>  {<br>    "public_ip_address_gw": "1.1.1.1",<br>    "tunnel1_inside_cidr": "169.254.21.0/30",<br>    "tunnel1_preshared_key": "fgdytdgdstsgshasgsgsashh",<br>    "tunnel2_inside_cidr": "169.254.21.4/30",<br>    "tunnel2_preshared_key": "fgdytdgdstsgshasgsgsashh"<br>  },<br>  {<br>    "public_ip_address_gw": "1.1.1.2",<br>    "tunnel1_inside_cidr": "169.254.21.28/30",<br>    "tunnel1_preshared_key": "fgdytdgdstsgshasgsgsashh",<br>    "tunnel2_inside_cidr": "169.254.21.32/30",<br>    "tunnel2_preshared_key": "fgdytdgdstsgshasgsgsashh"<br>  }<br>]</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->