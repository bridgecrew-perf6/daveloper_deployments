module "core_rg" {
  source = "git::https://github.com/drhbigdave/azure_modules.git//daveloper_infra_modules/resource_group?ref=v0.0.2"

  resource_group_name     = "daveloper_core_infra_rg"
  resource_group_location = "eastus"
  tags                    = local.tags
}

module "tf_remote_state" {
  #source = "../modules/storage_account"
  source = "git::https://github.com/drhbigdave/azure_modules.git//daveloper_infra_modules/storage_account?ref=v0.0.2"

  storage_account_name                          = "daveloperremotestate"
  resource_group_name                           = module.core_rg.resource_group.name
  resource_group_location                       = module.core_rg.resource_group.location
  storage_account_kind                          = "StorageV2"
  storage_account_tier                          = "Standard"
  storage_account_replication_type              = "LRS"
  storage_account_allow_blob_public_access      = false
  storage_account_is_hns_enabled                = false
  storage_account_network_rules_default_action  = "Deny"
  storage_account_network_rules_ip_rules        = [data.azurerm_key_vault_secret.drh_home_ip.value, data.azurerm_key_vault_secret.s_home_ip.value]
  storage_account_network_rules_vnet_subnet_ids = []
  storage_account_network_rules_bypass          = ["AzureServices"]
  tags                                          = local.tags

  storage_container_name = "terraform-remote-state"
  container_access_type  = "private"
}

module "core_kv" {
  source                                 = "git::https://github.com/drhbigdave/azure_modules.git//daveloper_infra_modules/key_vault?ref=v0.0.2"
  resource_group_name                    = module.core_rg.resource_group.name
  resource_group_location                = module.core_rg.resource_group.location
  key_vault_name                         = "daveloper-core-kv"
  key_vault_network_acls_default_action  = "Deny"
  key_vault_network_acls_ip_rules        = [data.azurerm_key_vault_secret.drh_home_ip.value, data.azurerm_key_vault_secret.s_home_ip.value]
  key_vault_network_acls_vnet_subnet_ids = []
  main_account_object_id                 = data.azurerm_key_vault_secret.drh_object_id.value
  tags                                   = local.tags
}

