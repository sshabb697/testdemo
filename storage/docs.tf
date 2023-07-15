locals {
  docs = templatefile("${path.module}/assets/docs.md", {
    name        = azurerm_storage_account.storage_account.name
    description = var.description

    performance_tier = azurerm_storage_account.storage_account.account_tier
    access_tier      = azurerm_storage_account.storage_account.access_tier
    account_kind     = azurerm_storage_account.storage_account.account_kind
    replication      = azurerm_storage_account.storage_account.account_replication_type

    key_vault_secrets = [
      for key_vault_secret in module.key_vault_secrets : {
        name         = key_vault_secret.name
        key_vault_id = key_vault_secret.key_vault_id
      }
    ]

    network_rules = azurerm_storage_account.storage_account.network_rules

    containers = [
      for container in azurerm_storage_container.containers :
      {
        name : container.name
      }
    ]

    private_endpoints = [
      for private_endpoint in azurerm_private_endpoint.private_endpoints : {
        name       = private_endpoint.name
        private_ip = private_endpoint.private_service_connection[0].private_ip_address
      }
    ]
  })
}
