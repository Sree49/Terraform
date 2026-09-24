terraform {
  backend "azurerm" {
    resource_group_name  = "RG"
    storage_account_name = "tfstatefilestore1678"
    container_name       = "tfstate-container"
    key                  = "terraform.tfstate"
  }
}