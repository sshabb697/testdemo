variable "name" {
  description = "Specifies the name of the storage account. Changing this forces a new resource to be created. This must be unique across the entire Azure service, not just within the resource group."
  type        = string
}
variable "description" {
  description = "Specifies the description of the storage account."
  type        = string
}
variable "resource_group_name" {
  description = "The name of the resource group in which to create the storage account. Changing this forces a new resource to be created."
  type        = string
}
variable "location" {
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  type        = string
}
variable "account_kind" {
  description = "Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Changing this forces a new resource to be created. Defaults to Storage"
  type        = string
  default     = "StorageV2"
}
variable "account_tier" {
  description = "Defines the Tier to use for this storage account. Valid options are Standard and Premium. Changing this forces a new resource to be created."
  type        = string
  default     = "Standard"
}
variable "account_replication_type" {
  description = "Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS and ZRS."
  type        = string
  default     = "GRS"
}
variable "access_tier" {
  description = "Defines the access tier for BlobStorage and StorageV2 accounts. Valid options are Hot and Cool."
  type        = string
  default     = "Hot"
}
variable "delete_retention_days" {
  description = "Specifies the number of days that the blob should be retained, between 1 and 365 days."
  type        = number
  default     = 31
}
variable "allowed_ips" {
  description = "List of allowed IPs."
  type        = list(string)
  default     = []
}
variable "allowed_subnet_ids" {
  description = "List of allowed subnet IDs."
  type        = list(string)
  default     = []
}
variable "containers" {
  description = "List of blob containers."
  type        = list(string)
  default     = []
}
variable "storage_management_policy_snapshot_rules" {
  description = "List of storage snapshot management policy rules."
  type = map(
    object({
      block_types  = list(string)
      prefix_match = list(string)
      actions      = map(number)
    })
  )
  default = {}
}
variable "storage_management_policy_blob_rules" {
  description = "List of storage blob management policy rules."
  type = map(
    object({
      block_types  = list(string)
      prefix_match = list(string)
      actions      = map(number)
    })
  )
  default = {}
}
variable "private_endpoints" {
  description = "Map of Private Endpoint configurations."
  type = map(object({
    subnet_id            = string
    private_dns_zone_ids = list(string)
    subresource_names    = list(string)
  }))
  default = {}
}
variable "key_vault" {
  description = "Key Vault configuration."
  type = object({
    id     = string
    prefix = string
    tags   = map(string)
  })
  default = null
}
variable "consul" {
  description = "Consul Key/Value configuration."
  type = object({
    prefix = string
    name   = string
  })
  default = null
}
variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
}

variable "cmk" {
  description = "Configuration for Customer Managed Key."
  type = object({
    key_vault = object({
      id   = string
      tags = map(string)
    })
    key_configuration = object({
      type  = string
      size  = number
      curve = string
      opts  = list(string)
    })
  })
  default = null
}
