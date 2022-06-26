variable "public_ip_address_gw" {
  type    = list(string)
  default = [""]

}

variable "tunnel1_inside_cidr" {


  default = ["169.254.21.0/30", "169.254.21.28/30"]

}

variable "tunnel2_inside_cidr" {
  default = ["169.254.21.4/30", "169.254.21.32/30"]
}

variable "tunnel1_preshared_key" {
  default = ["fgdytdgdstsgshasgsgsashh", "fgdytdgdstsgshasgsgsashh"] #Demo purposes only. Never use this in an actual environment. 


}

variable "tunnel2_preshared_key" {
  default = ["fgdytdgdstsgshasgsgsashh", "fgdytdgdstsgshasgsgsashh"] #Demo purposes only. Never use this in an actual environment.
}



