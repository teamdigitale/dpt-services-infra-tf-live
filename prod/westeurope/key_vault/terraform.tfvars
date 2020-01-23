terragrunt = {
  dependencies {
    paths = [
      "../resource_group"
    ]
  }

  terraform {
    source = "git::git@github.com:teamdigitale/dpt-services-infra-tf-modules.git//azurerm_key_vault"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

# Azure keyvault module variables
policy_object_list_map      = [
  # Luca Prete
  {
    object_id               = "c4209094-18fe-4902-840c-bd1242c8293a",
    key_permissions         = "create,delete,update,get,list",
    secret_permissions      = "set,delete,get,list",
    certificate_permissions = "create,delete,update,get,list"
  }
]
