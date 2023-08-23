variable "subnet_name" {
  type        = string
  description = "The name of the subnet to start the instance in"
}

variable "instance_name" {
  type        = string
  description = "The name of the instance"
}

variable "instance_type" {
  type        = string
  description = "The machine type of the instance"
}

variable "environment" {
  type        = string
  description = "The environment"
}
