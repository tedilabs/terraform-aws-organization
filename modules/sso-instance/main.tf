locals {
  metadata = {
    package = "terraform-aws-organization"
    version = trimspace(file("${path.module}/../../VERSION"))
    module  = basename(path.module)
    name    = var.name
  }
  module_tags = var.module_tags_enabled ? {
    "module.terraform.io/package"   = local.metadata.package
    "module.terraform.io/version"   = local.metadata.version
    "module.terraform.io/name"      = local.metadata.module
    "module.terraform.io/full-name" = "${local.metadata.package}/${local.metadata.module}"
    "module.terraform.io/instance"  = local.metadata.name
  } : {}
}

data "aws_ssoadmin_instances" "this" {
  region = var.region
}

locals {
  sso_instance_arn = tolist(data.aws_ssoadmin_instances.this.arns)[0]
}


###################################################
# AWS SSO Instance
###################################################

resource "awscc_sso_instance" "this" {
  name = var.name

  tags = [
    for key, value in merge(
      {
        "Name" = local.metadata.name
      },
      local.module_tags,
      var.tags,
      ) : {
      key   = key
      value = value
    }
  ]
}


###################################################
# Access Control Attributes for AWS SSO
###################################################

resource "aws_ssoadmin_instance_access_control_attributes" "this" {
  count = length(keys(var.access_control_attributes)) > 0 ? 1 : 0

  region = var.region

  instance_arn = local.sso_instance_arn

  dynamic "attribute" {
    for_each = var.access_control_attributes

    content {
      key = attribute.key

      value {
        source = [attribute.value]
      }
    }
  }
}


###################################################
# Additional Regions for AWS SSO
###################################################

resource "aws_ssoadmin_region" "this" {
  for_each = var.additional_regions

  region = var.region

  instance_arn = local.sso_instance_arn
  region_name  = each.value
}
