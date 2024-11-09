terraform {
  required_version = "1.9.8"

  backend "s3" {
    bucket = "gallery-tfstates"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.75.0"
    }

    archive = {
      source  = "hashicorp/archive"
      version = "2.6.0"
    }
  }
}
