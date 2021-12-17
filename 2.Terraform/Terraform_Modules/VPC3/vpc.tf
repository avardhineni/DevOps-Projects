provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket = "dptstorageaccount123"
    key    = "trf-iv/list.tfstate"
    region = "us-east-1"
  }
}

module "iwayqvpc" {

  source                 = "../modules/vpc"
  region                 = var.region
  vpc_cidr               = var.vpc_cidr
  instance_tenancy       = var.instance_tenancy
  project                = var.project
  cidr_pub_subnet        = var.cidr_pub_subnet
  pub_availability_zone  = var.pub_availability_zone
  cidr_priv_subnet       = var.cidr_priv_subnet
  priv_availability_zone = var.priv_availability_zone

}

