# Terraform Beginner Bootcamp 2023 -week 1

## Root module structure

Our root module structure is as follows:

- PROJECT_ROOT
  |- main.tf           - everything else.
  |- variables.tf      - stores the structure of input variables
  |- terraform.tfvars  - the data of variables we want to load into our Terraform project
  |- providers.tf      - defines required providers and their configuration
  |- outputs.tf        - stores our outputs
  |- README.md         - required for root modules

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)
