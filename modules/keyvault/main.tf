data "azurerm_key_vault" "kv" {
  name                = "terraform-secrets"
  resource_group_name = "RG"
}


data "azurerm_key_vault_secret" "subscription-id" {
  name         = "subscription-id"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "tenant-id" {
  name         = "tenant-id"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "client-secret" {
  name         = "client-secret"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "client-id" {
  name         = "client-id"
  key_vault_id = data.azurerm_key_vault.kv.id
}

