terraform {
  required_version = "1.14.0"

  backend "s3" {
    bucket = "gallery-tfstates"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.27.0"
    }

    archive = {
      source  = "hashicorp/archive"
      version = "2.7.1"
    }
  }
}
