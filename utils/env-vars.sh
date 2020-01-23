#!/usr/bin/env bash

# Variables and common functions file
# 
# The file contains a list of variables and common functions
# used loaded by all other scripts before their execution.
# 
# The .env.example file should be copied to .env file and
# customized with the own values.
# 

# Generic variables
SUBSCRIPTION='737cc34a-38e9-485a-8ea8-6268ca423db1'
RG_INFRA_NAME='dpt-services-infra-rg'
LOCATION='westeurope'
VAULT_INFRA_NAME='dpt-services-vault'

# Terraform variables
TERRAFORM_STORAGE_ACCOUNT_NAME='dptservicestf'
TERRAFORM_CONTAINER_NAME='dpt-services-tf'
TERRAFORM_VAULT_STORAGE_ACCOUNT_KEY='dpt-services-tf-storage'

err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $@" 2>&1| tee -a infra.log
}

log_date() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $@" >&1 | tee -a infra.log
}

run_cmd() {
  "$@" 2>&1| tee -a infra.log

  ret=$?
  if [[ $ret -eq 0 ]]; then
    log_date "Successfully ran [ $@ ]"
  else
    err "Error: Command [ $@ ] returned $ret"
    exit $ret
  fi
}
