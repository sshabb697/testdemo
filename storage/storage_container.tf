resource "azurerm_storage_container" "containers" {
  for_each = toset(var.containers)

  name                 = each.key
  storage_account_name = azurerm_storage_account.storage_account.name
}
