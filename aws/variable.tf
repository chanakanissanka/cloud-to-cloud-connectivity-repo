variable "tunnel_config" {
  type = map(object({
    public_ip_address_gw  = string
    tunnel1_inside_cidr   = string
    tunnel2_inside_cidr   = string
    tunnel1_preshared_key = string
    tunnel2_preshared_key = string
  }))

  default = {
    tn1= {
      public_ip_address_gw  = "1.1.1.1"
      tunnel1_inside_cidr   = "169.254.21.0/30"
      tunnel2_inside_cidr   = "169.254.21.4/30"
      tunnel1_preshared_key = "fgdytdgdstsgshasgsgsashh"
      tunnel2_preshared_key = "fgdytdgdstsgshasgsgsashh"
    }
    tn2 = {
      public_ip_address_gw  = "1.1.1.2"
      tunnel1_inside_cidr   = "169.254.21.28/30"
      tunnel2_inside_cidr   = "169.254.21.32/30"
      tunnel1_preshared_key = "fgdytdgdstsgshasgsgsashh"
      tunnel2_preshared_key = "fgdytdgdstsgshasgsgsashh"
    }
  }
  sensitive = true
}
