output "lb_backend_address_pool_id" {
  value = azurerm_lb_backend_address_pool.lb_backend_pool.id
}

output "lb_probe_id" {
  value = azurerm_lb_probe.lb_probe.id
}