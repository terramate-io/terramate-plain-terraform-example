variable "vpc_name" {
  type        = string
  description = "The Name tag of the VPC"
}

variable "vpc_cidr_block" {
  type        = string
  description = "The CIDR block of the VPC"
}

variable "subnet_name" {
  type        = string
  description = "The name of the Subnet"
}

variable "subnet_cidr_block" {
  type        = string
  description = "The CIDR block of the Subnet"
}

variable "environment" {
  type        = string
  description = "The environment"
}
