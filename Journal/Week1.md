# Terraform Beginner Bootcamp 2023 - Week 1

## Root Module Structure

Our root module structure is as follows:

```
- PROJECT_ROOT
  - variables.tf      : Stores the structure of input variables
  - main.tf           : Contains everything else
  - providers.tf      : Defines required providers and their configuration
  - outputs.tf        : Stores the outputs
  - terraform.tfvars  : Contains the data of variables to load into the project
  - README.md         : Required for root modules
```
  
[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)


