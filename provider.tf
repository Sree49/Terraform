terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "5.6.0"
    }
  }
}

module "Keyvault" {
  source      = "./modules/keyvault"
  RG_Name     = var.RG_Name
  RG_Location = var.RG_Location
}

provider "azurerm" {
  # Configuration options
  subscription_id = module.Keyvault.subscription-id
  tenant_id       = module.Keyvault.tenant-id
  client_id       = module.Keyvault.client-id
  client_secret   = module.Keyvault.client-secret
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }


  }
}