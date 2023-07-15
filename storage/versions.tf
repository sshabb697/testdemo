terraform {
  required_version = ">= 0.14"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.41.0"
    }
    consul = {
      source  = "hashicorp/consul"
      version = ">= 2.10.0"
    }
  }
}
