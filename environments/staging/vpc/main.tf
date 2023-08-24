module "vpc" {
  source = "../../../modules/vpc"

  environment = "staging"

  vpc_name       = "my-vpc-staging"
  vpc_cidr_block = "10.0.0.0/16"

  subnet_name       = "my-subnet-staging"
  subnet_cidr_block = "10.0.1.0/24"
}
