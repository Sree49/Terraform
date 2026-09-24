output "subscription-id" {
  value     = data.azurerm_key_vault_secret.subscription-id.value
  sensitive = true
}

output "tenant-id" {
  value     = data.azurerm_key_vault_secret.tenant-id.value
  sensitive = true
}

output "client-secret" {
  value     = data.azurerm_key_vault_secret.client-secret.value
  sensitive = true
}

output "client-id" {
  value     = data.azurerm_key_vault_secret.client-id.value
  sensitive = true
}

