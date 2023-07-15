resource "consul_keys" "storage_account" {
  count = var.consul != null ? 1 : 0

  dynamic "key" {
    for_each = {
      id                  = azurerm_storage_account.storage_account.id
      name                = azurerm_storage_account.storage_account.name
      resource-group-name = azurerm_storage_account.storage_account.resource_group_name
    }

    content {
      path   = "${local.consul_prefix}/${key.key}"
      value  = key.value
      delete = true
    }
  }

  dynamic "key" {
    for_each = azurerm_private_endpoint.private_endpoints

    content {
      path   = "${local.consul_prefix}/private-ip/${key.key}"
      value  = key.value.private_service_connection[0].private_ip_address
      delete = true
    }
  }
}
