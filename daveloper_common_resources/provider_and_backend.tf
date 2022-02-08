terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.94.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "daveloper_core_infra_rg"
    storage_account_name = "daveloperremotestate"
    container_name       = "terraform-remote-state"
    key                  = "daveloper-core-infra.terraform.tfstate"
  }
}
provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}
