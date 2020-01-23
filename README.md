# Terraform scripts for Department of Innovation

The repository contains the Terraform scripts to provision and maintain the Italian Innovation Department cloud infrastructure.

## The Italian Department of Innovation

More informations about the Italian Department of Innovation can be found on the Department [website](https://innovazione.gov.it/)

## Tools references

The tools used in this repository are

* [Terragrunt](https://github.com/gruntwork-io/terragrunt)
* [Terraform](https://www.terraform.io/)

## Repository directories and files structure

```
Environment
    |_Deployment area
        |_ Module
```

The root folder contains one or more *environments*, for example *dev*, *staging*, *prod*

Each *environment* contains one or more *deployment areas*, for example *westeurope*.

Each deployment area contains one or more live scripts that have a one to one correspondence with a Terraform module. The Terraform modules are maintained in a [separate repository](https://github.com/teamdigitale/dpt-services-tf-modules).

Module variables and main Terragrunt configuration files are stored in *terraform.tfvars* files.
Modules can also optionally inherit shared variables from higher level folders. These variables may be stored at each level of the hierarchy in the *vars.tfvars* files. For example, the *westeurope* folder under each environment contains the variable `location = "westeurope"`, that is inherited by all the underlying modules.

## How to use the scripts

The sections describes how to provision the Docs Italia infrastructure using the Terraform scripts in this repository.

Before using Terraform, 

* Be sure to be owner of the Azure subscription

* Be sure to be global administrator of the Azure AD tenant

* Make sure that *env-vars.sh* reflects your current environment

The very first time, only once, init the Azure environment to support Terraform:

```shell
cd utils
source az-init.sh
```

Each time, before using Terraform run

```shell
cd utils
source az-export.sh
```

To provision an entire infrastructure, run from the root folder

```shell
terragrunt apply-all
```

>NOTE: Substitute apply-all with destroy-all to destroy an entire environment

To apply a single live module, go in a live module folder and run

```shell
terragrunt apply
```

To provision a single module, go into the specific folder and run the same command.

## Local tests

If you have not committed a Terraform module yet and you'd like to test it run from the live module folder:

```shell
terragrunt apply --terragrunt-source PATH_TO_YOUR_LOCAL_MODULE_DIR
```

## How to clear the local cache

Sometimes you may need to remove the local Terragrunt cache. To do so run

```shell
find . -type d -name ".terragrunt-cache" -prune -exec rm -rf {} \;
```

## Provision a new infrastructure

```shell
cd io-infrastructure-live

# Export env vars
cd utils
source az-export.sh

# Optionally set TERRAGRUNT_SOURCE_UPDATE to true
# to download the latest Terraform module each time
# an apply is executed
export TERRAGRUNT_SOURCE_UPDATE=true

# Deploy the components of the dev environment, under the West Europe Azure DC location
cd ../prod/westeurope

# Resource group
cd resource_group && terragrunt apply

# Networking: vnet and subnets
cd ../vnet_common && terragrunt apply
cd ../subnet_k8s-01 && terragrunt apply

# Keyvault
cd ../key_vault && terragrunt apply

# Kubernetes
cd ../key_vault_secret_ssh_keys_vm && terragrunt apply
cd ../service_principal_k8s-01 && terragrunt apply
cd ../service_principal_k8s-01-aad-server && terragrunt apply
```

**Manual operations required**

* Navigate to https://portal.azure.com -> Azure Active Directory -> io-{dev|prod}-sp-k8s-01-aad-server

* API permissions -> Grant admin consent -> yes

* Expose an API -> /user_impersonation -> Admins only -> Save

```shell
cd ../service_principal_k8s-01-aad-client && terragrunt apply
```

**Manual operations required**

* Navigate to https://portal.azure.com -> Azure Active Directory -> io-{dev|prod}-sp-k8s-01-aad-client

API permissions -> Grant admin consent -> yes

## How to contribute

Contributions are welcome. Feel free to [open issues](./issues) and submit a [pull request](./pulls) at any time.

## License

Copyright (c) 2020 Presidenza del Consiglio dei Ministri

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
