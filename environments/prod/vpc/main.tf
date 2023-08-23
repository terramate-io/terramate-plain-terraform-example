module "vpc" {
  source = "../../../modules/vpc"

  environment = "prod"

  vpc_name       = "my-vpc-prod"
  vpc_cidr_block = "10.0.0.0/16"

  subnet_name       = "my-subnet-prod"
  subnet_cidr_block = "10.0.1.0/24"
}
