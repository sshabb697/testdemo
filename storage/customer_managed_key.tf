data "azurerm_client_config" "current" {}
resource "azurerm_key_vault_access_policy" "customer_managed_key" {
  count = var.cmk != null ? 1 : 0

  key_vault_id    = var.cmk.key_vault.id
  tenant_id       = data.azurerm_client_config.current.tenant_id
  object_id       = azurerm_storage_account.storage_account.identity[0].principal_id
  key_permissions = ["get", "unwrapkey", "wrapkey"]
}
resource "azurerm_key_vault_key" "customer_managed_key" {
  count = var.cmk != null ? 1 : 0

  name         = "${azurerm_storage_account.storage_account.name}-cmk"
  key_vault_id = var.cmk.key_vault.id
  key_type     = local.cmk_key_configuration.type
  key_size     = local.cmk_key_configuration.size
  curve        = local.cmk_key_configuration.curve
  key_opts     = local.cmk_key_configuration.opts

  tags = var.cmk.key_vault.tags
}
resource "azurerm_storage_account_customer_managed_key" "customer_managed_key" {
  count = var.cmk != null ? 1 : 0

  storage_account_id = azurerm_storage_account.storage_account.id
  key_vault_id       = var.cmk.key_vault.id
  key_name           = azurerm_key_vault_key.customer_managed_key[0].name

  depends_on = [
    azurerm_key_vault_access_policy.customer_managed_key
  ]
}
