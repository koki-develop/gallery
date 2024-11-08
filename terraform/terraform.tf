terraform {
  backend "s3" {
    bucket = "gallery-tfstates"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
