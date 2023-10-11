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


## Terraform and Input Variables

[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

### Terraform Cloud Variables

In terraform we can set two kinds of variables:
- Environmental Variables - those you would set in your bash terminal eg. AWS credentials
- Terraform Variables - those that you would normally set in your tfvars file
We can set Terraform Cloud variables to be sensitive so they arrre not shown visibly in the UI

### Loading Terraform Input Variables

### var flag
We can use the `-var` flag to set an input variable or overide a variable in the tfvars file eg. `terraform - user_ud="my-user_id"`

### var-file flag

- TODO: document this flag

### terraform.tfvars

This is the default file to load in terraform variables in bulk blunk

### auto.tfvars
- TODO: document this functionality for terraform cloud

### order of terraform variables

_ TODO: Document which terraform variables takes precedence. 