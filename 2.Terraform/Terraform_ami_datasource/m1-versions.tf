terraform {
  required_version = "~>1.0.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.69"
    }
  }
  backend "s3" {
    bucket = "dptstorageaccount123"
    key    = "trf-iv/list.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}