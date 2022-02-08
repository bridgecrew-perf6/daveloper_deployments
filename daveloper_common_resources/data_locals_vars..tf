data "azurerm_key_vault" "core_kv" {
  name                = "daveloper-core-kv"
  resource_group_name = "daveloper_core_infra_rg"
}
data "azurerm_key_vault_secret" "drh_home_ip" {
  name         = "drh-home-ip"
  key_vault_id = data.azurerm_key_vault.core_kv.id
}
data "azurerm_key_vault_secret" "s_home_ip" {
  name         = "s-home-ip"
  key_vault_id = data.azurerm_key_vault.core_kv.id
}
data "azurerm_key_vault_secret" "drh_object_id" {
  name         = "drh-object-id"
  key_vault_id = data.azurerm_key_vault.core_kv.id
}

#########################################################
## Locals
#########################################################

locals {
  tags = {
    project = "daveloper core infra"
  }
}
