output "VNet_Name" {
  value = azurerm_virtual_network.VNET.name
}

output "VNet_ID" {
  value = azurerm_virtual_network.VNET.id
}

output "subnet_id" {
  value = azurerm_subnet.subnet.id
}