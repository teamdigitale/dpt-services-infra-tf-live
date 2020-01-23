# Creates a log analytics workspace.

terragrunt = {
  dependencies {
    paths = [
      "../resource_group"
    ]
  }

  terraform {
    source = "git::git@github.com:teamdigitale/dpt-services-infra-tf-modules.git//azurerm_log_analytics_workspace"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

# Log workspace analytics module variables

log_analytics_workspace_name_suffix = "01"
azurerm_log_analytics_workspace_sku = "PerGB2018"
azurerm_log_analytics_solution_list = [
  {
    solution_name = "ContainerInsights"
  },
  {
    solution_name = "SecurityCenterFree"
  },
  {
    solution_name = "SecurityInsights"
  },
  {
    solution_name = "KeyVaultAnalytics"
  },
  {
    solution_name = "AzureSQLAnalytics"
  },
  {
    solution_name = "ADAssessment"
  },
  {
    solution_name = "AzureNetworking"
  },
  {
    solution_name = "AzureActivity"
  },
  {
    solution_name = "SQLAssessment"
  }
]
