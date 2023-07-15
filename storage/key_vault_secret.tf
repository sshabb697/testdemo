module "key_vault_secrets" {
  source = "https://artifactory.shapingdixonsretail.com/artifactory/terraform-local/terraform-azure-key-vault-secret/0.1.0.tar.gz"

  for_each = var.key_vault != null ? {
    access-key        = azurerm_storage_account.storage_account.primary_access_key
    connection-string = azurerm_storage_account.storage_account.primary_connection_string
  } : {}

  name  = "storage-account-${var.key_vault.prefix}-${each.key}"
  value = each.value

  key_vault_id = var.key_vault.id

  consul = var.consul != null ? {
    prefix = local.consul_prefix
    name   = each.key
  } : null

  tags = var.key_vault.tags
}
