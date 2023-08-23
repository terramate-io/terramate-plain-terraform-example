
resource "null_resource" "aws_vpc" {
  triggers = {
    resource = "aws_vpc"

    description = "A null aws_vpc for demo reasons."

    attributes = jsonencode({
      cidr_block = var.vpc_cidr_block

      tags = {
        Name        = var.vpc_name
        Environment = var.environment
      }
    })
  }
}

resource "null_resource" "subnet" {
  triggers = {
    resource = "aws_subnet"

    description = "A null aws_subnet for demo reasons, connected to the null aws_vpc via .id"

    attributes = jsonencode({
      vpc_id     = null_resource.aws_vpc.id
      cidr_block = var.subnet_cidr_block

      tags = {
        Name        = var.subnet_name
        Environment = var.environment
      }
    })
  }
}
