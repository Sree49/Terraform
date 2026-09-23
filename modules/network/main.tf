resource "azurerm_virtual_network" "VNET" {
  name                = var.VNET_Name
  location            = var.RG_Location
  resource_group_name = var.RG_Name
  address_space       = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "subnet1"
  resource_group_name  = var.RG_Name
  virtual_network_name = var.VNET_Name
  address_prefixes     = ["10.0.1.0/25"]
  depends_on           = [azurerm_virtual_network.VNET]
}

resource "azurerm_network_security_group" "NSG" {
  name                = "NSG1"
  location            = var.RG_Location
  resource_group_name = var.RG_Name

security_rule {
    name                       = "rule1"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}

resource "azurerm_subnet_network_security_group_association" "NSGAssociation" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.NSG.id
  depends_on = [azurerm_subnet.subnet, azurerm_network_security_group.NSG]
}


