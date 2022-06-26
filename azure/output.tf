output "public_ip_address_gw" {
  value = azurerm_public_ip.example.*.ip_address
}
