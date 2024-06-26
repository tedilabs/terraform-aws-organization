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
# Organization Acoount
###################################################

# INFO: Not supported attributes
# - 'create_govcloud'
resource "aws_organizations_account" "this" {
  name              = var.name
  email             = var.email
  parent_id         = coalesce(var.parent_id, local.organization_root_id)
  close_on_deletion = var.close_on_delete

  iam_user_access_to_billing = var.iam_user_access_to_billing_allowed ? "ALLOW" : "DENY"
  role_name                  = var.preconfigured_administrator_role_name


  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )

  # There is no AWS Organizations API for reading role_name
  lifecycle {
    ignore_changes = [
      # INFO: Need to change terraform states manually for imported account
      # iam_user_access_to_billing,
      role_name,
    ]
  }
}


###################################################
# AWS Managed Policies
###################################################

resource "aws_organizations_policy_attachment" "this" {
  for_each = toset(var.policies)

  target_id = aws_organizations_account.this.id
  policy_id = each.key

  skip_destroy = false
}
