module "instance" {
  source = "../../../modules/instance"

  environment = "staging"

  subnet_name = "my-subnet-staging" # must match subnet_name in VPC stack (../vpc)

  instance_name = "my-machine-staging"
  instance_type = "t3.micro"
}
