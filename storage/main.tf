locals {
  allowed_ips = [
    for ip in var.allowed_ips : ((tonumber(regex(".+/(?P<bits>[[:digit:]]{2})", ip)["bits"]) <= 30) ? ip : cidrhost(ip, 0))
  ]
}
resource "azurerm_storage_account" "storage_account" {
  name                = lower(replace(var.name, "-", ""))
  resource_group_name = var.resource_group_name
  location            = var.location

  account_kind             = var.account_kind
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  access_tier              = var.access_tier

  enable_https_traffic_only = true
  allow_blob_public_access  = false
  min_tls_version           = "TLS1_2"

  network_rules {
    default_action = "Deny"

    bypass = [
      "AzureServices",
    ]

    ip_rules = local.allowed_ips

    virtual_network_subnet_ids = var.allowed_subnet_ids
  }

  identity {
    type = "SystemAssigned"
  }

  blob_properties {
    delete_retention_policy {
      days = var.delete_retention_days
    }
  }

  tags = var.tags
}
