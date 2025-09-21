locals {
  metadata = {
    package = "terraform-aws-organization"
    version = trimspace(file("${path.module}/../../VERSION"))
    module  = basename(path.module)
    name    = "attributes"
  }
}

data "aws_ssoadmin_instances" "this" {}

locals {
  sso_instance_arn = tolist(data.aws_ssoadmin_instances.this.arns)[0]
}


###################################################
# Access Control Attributes for AWS SSO
###################################################

resource "aws_ssoadmin_instance_access_control_attributes" "this" {
  count = length(keys(var.attributes)) > 0 ? 1 : 0

  region = var.region

  instance_arn = local.sso_instance_arn

  dynamic "attribute" {
    for_each = var.attributes

    content {
      key = attribute.key

      value {
        source = [attribute.value]
      }
    }
  }
}
