resource "azurerm_private_endpoint" "private_endpoints" {
  for_each = var.private_endpoints

  name                = "${azurerm_storage_account.storage_account.name}.${each.key}.core.windows.net"
  resource_group_name = azurerm_storage_account.storage_account.resource_group_name
  location            = azurerm_storage_account.storage_account.location

  subnet_id = each.value.subnet_id

  private_dns_zone_group {
    name                 = azurerm_storage_account.storage_account.name
    private_dns_zone_ids = each.value.private_dns_zone_ids
  }

  private_service_connection {
    name                           = azurerm_storage_account.storage_account.name
    private_connection_resource_id = azurerm_storage_account.storage_account.id
    is_manual_connection           = false

    subresource_names = each.value.subresource_names
  }

  tags = var.tags
}
