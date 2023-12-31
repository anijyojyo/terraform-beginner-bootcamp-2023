# This is my first change !
# This is my second change !
terraform {

  cloud {
    organization = "anijyojyo"

    workspaces {
      name = "terra-house-7"
    }
  }



  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
  


    aws = {
      source = "hashicorp/aws"
      version = "5.19.0"
    }
  }
}

provider "aws" {
  # Configuration options
}





provider "random" {
  # Configuration options
}

# https://registry.terraform.io/providers/ContentSquare/random/latest/docs/resources/string
resource "random_string" "bucket_name" {
  lower = true
  upper = false
  length  = 32
  special = false

}
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "example" {
  # Bucket naming Rules
  # https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html
  bucket = random_string.bucket_name.result

  
}


output "random_bucket_name" {
  value = random_string.bucket_name.result
}

 