module "instance" {
  source = "../../../modules/instance"

  environment = "prod"

  subnet_name = "my-subnet-prod" # must match subnet_name in VPC stack (../vpc)

  instance_name = "my-machine-prod"
  instance_type = "t3.micro"
}
