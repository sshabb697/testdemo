resource "azurerm_storage_management_policy" "storage_management_policy" {
  count = length(var.storage_management_policy_snapshot_rules) > 0 || length(var.storage_management_policy_blob_rules) > 0 ? 1 : 0

  storage_account_id = azurerm_storage_account.storage_account.id

  dynamic "rule" {
    for_each = var.storage_management_policy_snapshot_rules

    content {
      name    = rule.key
      enabled = true

      filters {
        blob_types   = rule.value.block_types
        prefix_match = rule.value.prefix_match
      }

      actions {
        snapshot {
          delete_after_days_since_creation_greater_than = lookup(rule.value.actions, "delete_after_days_since_creation_greater_than", null)
        }
      }
    }
  }

  dynamic "rule" {
    for_each = var.storage_management_policy_blob_rules

    content {
      name    = rule.key
      enabled = true

      filters {
        blob_types   = rule.value.block_types
        prefix_match = rule.value.prefix_match
      }

      actions {
        base_blob {
          tier_to_cool_after_days_since_modification_greater_than    = lookup(rule.value.actions, "tier_to_cool_after_days_since_modification_greater_than", null)
          tier_to_archive_after_days_since_modification_greater_than = lookup(rule.value.actions, "tier_to_archive_after_days_since_modification_greater_than", null)
          delete_after_days_since_modification_greater_than          = lookup(rule.value.actions, "delete_after_days_since_modification_greater_than", null)
        }
      }
    }
  }
}
