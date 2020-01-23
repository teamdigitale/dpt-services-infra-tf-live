terragrunt = {

  terraform {
    source = "git::git@github.com:teamdigitale/dpt-services-infra-tf-modules.git//azurerm_storage_account"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

# Storage account module related variables
storage_account_name                                  = "dptservices01"
azurerm_storage_account_account_tier                  = "Premium"
azurerm_storage_account_account_replication_type      = "GRS"
azurerm_storage_account_network_rules_default_action  = "Allow"
