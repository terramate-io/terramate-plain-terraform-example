
# configuration is in ./locals.tf

data "null_data_source" "aws_subnet" {
  inputs = {
    id = "my-subnet"

    description = "A null data source reading the subnet by tag to use for demo reasons."

    filters = jsonencode([{
      name   = "tag:Name"
      values = [var.subnet_name]
      }, {
      name   = "tag:Environment"
      values = [var.environment]
    }])
  }
}

data "null_data_source" "aws_ami" {
  inputs = {
    id = "my-ami"

    description = "A null data source reading the AMI to use for demo reasons."

    filter = jsonencode({
      name   = "name"
      values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    })

    owners = "099720109477" # Canonical
  }
}

resource "null_resource" "aws_instance" {
  triggers = {
    resource = "aws_instance"

    description = "A null aws_instance for demo reasons."

    attributes = jsonencode({
      ami = data.null_data_source.aws_ami.outputs.id

      instance_type = var.instance_type

      subnet_id = data.null_data_source.aws_subnet.outputs.id

      tags = {
        Name        = var.instance_name
        Environment = var.environment
      }
    })
  }
}
