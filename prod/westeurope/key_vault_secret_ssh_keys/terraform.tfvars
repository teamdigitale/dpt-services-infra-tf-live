terragrunt = {
  dependencies {
    paths = [
      "../key_vault"
    ]
  }

  terraform {
    source = "git::git@github.com:teamdigitale/dpt-services-infra-tf-modules.git//azurerm_key_vault_ssh_keys"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

azurerm_key_vault_ssh_keys_private_secret_name = "terraformsshkey"
azurerm_key_vault_ssh_keys_public_secret_name  = "terraformsshkeypub"
azurerm_key_vault_ssh_keys_email               = "it-services@teamdigitale.governo.it"
