resource "azurerm_public_ip" "LBPubip" {
  name                = "LBPubIP"
  location            = var.RG_Location
  resource_group_name = var.RG_Name
  allocation_method   = "Static"
  sku="Standard"
}

resource "azurerm_lb" "LB" {
  name                = "loadbalancer"
  location            = var.RG_Location
  resource_group_name = var.RG_Name
sku="Standard"
sku_tier="Regional"
  frontend_ip_configuration {
    name                 = "LBPubIP"
    public_ip_address_id = azurerm_public_ip.LBPubip.id
  }
  
}

resource "azurerm_lb_backend_address_pool" "lb_backend_pool" {
  loadbalancer_id = azurerm_lb.LB.id
  name            = "BackEndAddressPool"
}



resource "azurerm_lb_probe" "lb_probe" {
  loadbalancer_id = azurerm_lb.LB.id
  name            = "http-probe"
  port            = 80
  protocol        = "Tcp"
}


resource "azurerm_lb_rule" "lb_rule" {
  loadbalancer_id                = azurerm_lb.LB.id
  name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  probe_id                       = azurerm_lb_probe.lb_probe.id
  frontend_ip_configuration_name = "LBPubIP"
}