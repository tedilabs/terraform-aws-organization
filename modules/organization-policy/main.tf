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

data "aws_organizations_organization" "this" {}

locals {
  organization_root_id = data.aws_organizations_organization.this.roots[0].id
}


###################################################
# Organization Policy
###################################################

resource "aws_organizations_policy" "this" {
  name         = var.name
  description  = var.description
  skip_destroy = var.skip_destroy

  type    = var.type
  content = var.content

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )
}
