terragrunt = {
  dependencies {
    paths = [
      "../resource_group"
    ]
  }

  terraform {
    source = "git::git@github.com:teamdigitale/dpt-services-infra-tf-modules.git//azurerm_vnet"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

# Azure vnet module variables
vnet_name                             = "common"
azurerm_virtual_network_address_space = "10.0.0.0/8"
