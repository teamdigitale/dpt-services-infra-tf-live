# Creates a public IP that will be then associated to the nginx ingress
# of the k8s-01 cluster

terragrunt = {
  dependencies {
    paths = [
      "../resource_group",
      "../kubernetes_cluster_k8s-01"
    ]
  }

  terraform {
    source = "git::git@github.com:teamdigitale/dpt-services-infra-tf-modules.git//azurerm_public_ip"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

# Public IP module variables
azurerm_public_ip_name      = "k8s-01"
azurerm_resource_group_name = "MC_dpt-services-prod-rg_dpt-services-prod-aks-k8s-01_westeurope"
