terraform {
  required_version = "~> 1.1.9"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Provider Block
provider "aws" {
  region = var.region
}


module "megavpc"  {

source = "/home/ec2-user/vpc"
region = var.region
vpc_cidr = var.vpc_cidr
instance_tenancy = var.instance_tenancy
project = var.project
cidr_pub_subnet = var.cidr_pub_subnet
pub_availability_zone = var.pub_availability_zone
cidr_priv_subnet = var.cidr_priv_subnet
priv_availability_zone = var.priv_availability_zone

}

