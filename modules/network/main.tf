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
  security_rule {
    name                       = "rule2"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = "*"
  }

}

resource "azurerm_subnet_network_security_group_association" "NSGAssociation" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.NSG.id
  depends_on = [azurerm_subnet.subnet, azurerm_network_security_group.NSG]
}


resource "azurerm_nat_gateway" "nat-gateway" {
  name                    = "nat-gateway"
  location                = var.RG_Location
  resource_group_name     = var.RG_Name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
}


resource "azurerm_public_ip" "nat-gateway-pip" {
  name                = "nat-gateway-pip"
  location            = var.RG_Location
  resource_group_name = var.RG_Name
  allocation_method   = "Static"
  sku                 = "Standard"
}



resource "azurerm_nat_gateway_public_ip_association" "nat-gateway-pip-association" {
  nat_gateway_id       = azurerm_nat_gateway.nat-gateway.id
  public_ip_address_id = azurerm_public_ip.nat-gateway-pip.id
  depends_on = [azurerm_nat_gateway.nat-gateway, azurerm_public_ip.nat-gateway-pip]
}

resource "azurerm_subnet_nat_gateway_association" "nat-gateway-subnet-association" {
  subnet_id      = azurerm_subnet.subnet.id
  nat_gateway_id = azurerm_nat_gateway.nat-gateway.id
  depends_on = [azurerm_subnet.subnet, azurerm_nat_gateway.nat-gateway]
}