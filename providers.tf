terraform {
#   cloud {
#     organization = "afor-linda-odoma"

#     workspaces {
#       name = "terra-house-1"
#     }
#   }

  
  required_providers {  
    aws = {
      source = "hashicorp/aws"
      version = "5.19.0"
    }
  }
}

provider "aws" {
}

provider "random" {
  # Configuration options
}