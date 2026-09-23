

resource "azurerm_subnet" "bastionsubnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = var.RG_Name
  virtual_network_name = var.VNET_Name
  address_prefixes     = ["10.0.1.128/25"]
}

resource "azurerm_public_ip" "pubip" {
  name                = "pip"
  location            = var.RG_Location
  resource_group_name = var.RG_Name
  allocation_method   = "Static"
  sku                 = "Standard"
  
}

resource "azurerm_bastion_host" "bastion" {
  name                = "bastion"
  location            = var.RG_Location
  resource_group_name = var.RG_Name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastionsubnet.id
    public_ip_address_id = azurerm_public_ip.pubip.id
  }
  
}
