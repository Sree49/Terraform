resource "tls_private_key" "privatekey" {
  algorithm = "RSA"
  rsa_bits  = 4098
}

resource "local_file" "pemkey" {
  filename   = "./modules/vmss/pemkey"
  content    = tls_private_key.privatekey.private_key_pem
  depends_on = [tls_private_key.privatekey]
}


resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  name                 = "vmss"
  resource_group_name  = var.RG_Name
  location             = var.RG_Location
  sku                  = "Standard_D4_v5"
  instances            = 2
  admin_username       = "adminuser"
  computer_name_prefix = "vm-"
  automatic_instance_repair {
    enabled      = true
    grace_period = "PT10M"
  }
  health_probe_id = var.lb_probe_id

  #user_data = filebase64("${path.module}/cloud-init.yaml")
  custom_data = filebase64("${path.module}/cloud-init.yaml")



  admin_ssh_key {
    username   = "adminuser"
    public_key = tls_private_key.privatekey.public_key_openssh
  }
  tags = {
    environment = "Terraform-Demo"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }


  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "vmssnic"
    primary = true

    ip_configuration {
      name                                   = "internal"
      primary                                = true
      subnet_id                              = var.subnet_id
      load_balancer_backend_address_pool_ids = [var.lb_backend_address_pool_id]
    }

  }

}
