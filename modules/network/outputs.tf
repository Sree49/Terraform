output "VNet_Name" {
  value = azurerm_virtual_network.VNET.name
}

output "VNet_ID" {
  value = azurerm_virtual_network.VNET.id
}

output "subnet_id" {
  value = azurerm_subnet.subnet.id
}

output "natgateway_id" {
  value = azurerm_nat_gateway.nat-gateway.id
}

output "nat-gateway-pip" {
  value = azurerm_public_ip.nat-gateway-pip
}