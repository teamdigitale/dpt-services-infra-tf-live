terragrunt = {
  dependencies {
    paths = [
      "../resource_group"
    ]
  }

  terraform {
    source = "git::git@github.com:teamdigitale/dpt-services-infra-tf-modules.git//azurerm_storage_account"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

# Storage account module related variables
storage_account_name                             = "backups"
azurerm_storage_account_account_kind             = "StorageV2"
azurerm_storage_account_account_tier             = "Standard"
azurerm_storage_account_account_replication_type = "LRS"
azurerm_storage_account_is_hns_enabled           = "true"
set_firewall                                     = false
