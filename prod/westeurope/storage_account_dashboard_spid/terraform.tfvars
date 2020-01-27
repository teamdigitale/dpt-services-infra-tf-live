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
storage_account_name                             = "spid"
azurerm_storage_account_account_kind             = "StorageV2"
azurerm_storage_account_account_tier             = "Standard"
azurerm_storage_account_account_replication_type = "LRS"
azurerm_storage_account_is_hns_enabled           = true
set_firewall                                     = false

# TODO: Add option to create filesystem for Azure Data Lake Gen2
# See https://github.com/terraform-providers/terraform-provider-azurerm/issues/3319
# for details
