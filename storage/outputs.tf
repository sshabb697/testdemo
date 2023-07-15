output "docs" {
  value = local.docs
}
output "id" {
  value = azurerm_storage_account.storage_account.id
}
output "name" {
  value = azurerm_storage_account.storage_account.name
}
output "resource_group_name" {
  value = azurerm_storage_account.storage_account.resource_group_name
}
output "consul_prefix" {
  value = var.consul != null ? local.consul_prefix : null
}
output "identity" {
  value = azurerm_storage_account.storage_account.identity
}
