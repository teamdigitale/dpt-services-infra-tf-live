#!/usr/bin/env bash

# Azure init script
#
# It initializes the Azure infrastructure, in order to
# be provisioned with Terraform.
#

if [ ! -f env-vars.sh ]; then
  echo """
    ERROR:
    .env file missing. Please copy the .env.example file into a .env file
    and customize it with your deployment values. Then, run this script again.
      """
  exit 1
fi

# shellcheck disable=SC1091
source env-vars.sh

function generate_random_pwd() {
  "$(LC_ALL=C tr -dc 'A-Za-z0-9!"#$%&'\''()*+,-./:;<=>?@[\]^_{|}~' </dev/urandom | head -c 20)"
}

# Set account subscription
run_cmd az account set -s "${SUBSCRIPTION}"

# Create resource group
run_cmd az group create \
  --location "${LOCATION}" \
  --subscription "${SUBSCRIPTION}" \
  --name "${RG_INFRA_NAME}"

# Create the infrastructure vault
run_cmd az keyvault create \
  --name "${VAULT_INFRA_NAME}" \
  --resource-group "${RG_INFRA_NAME}" \
  --location "${LOCATION}" \
  --output none

# Terraform specific

# Create storage account to store the Terraform states and save
# the secret in the vault
run_cmd az storage account create \
  --resource-group "${RG_INFRA_NAME}" \
  --name "${TERRAFORM_STORAGE_ACCOUNT_NAME}" \
  --sku Standard_LRS \
  --encryption-services blob

TERRAFORM_ACCOUNT_KEY=$(az storage account keys list \
  --resource-group "${RG_INFRA_NAME}" \
  --account-name "${TERRAFORM_STORAGE_ACCOUNT_NAME}" \
  --query [0].value -o tsv)

# Create storage container
run_cmd az storage container create \
  --name "$TERRAFORM_CONTAINER_NAME" \
  --account-name "${TERRAFORM_STORAGE_ACCOUNT_NAME}" \
  --account-key "${TERRAFORM_ACCOUNT_KEY}"

# Save account key for storage account
run_cmd az keyvault secret set \
  --name "${TERRAFORM_VAULT_STORAGE_ACCOUNT_KEY}" \
  --vault-name "${VAULT_INFRA_NAME}" \
  --value "${TERRAFORM_ACCOUNT_KEY}"
