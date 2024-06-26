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

data "aws_ssoadmin_instances" "this" {}

locals {
  sso_instance_arn = tolist(data.aws_ssoadmin_instances.this.arns)[0]

  session_duration = {
    "H" = floor(var.session_duration / 3600)
    "M" = floor((var.session_duration % 3600) / 60)
    "S" = floor((var.session_duration % 3600) % 60)
  }
  session_duration_iso_8601 = join("", [
    "PT",
    join("", [
      for unit, n in local.session_duration :
      "${n}${unit}"
      if n > 0
    ])
  ])
}


resource "aws_ssoadmin_permission_set" "this" {
  name         = var.name
  description  = var.description
  instance_arn = local.sso_instance_arn

  session_duration = local.session_duration_iso_8601
  relay_state      = var.relay_state

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )
}


###################################################
# Managed Policies
###################################################

resource "aws_ssoadmin_managed_policy_attachment" "this" {
  for_each = {
    for policy in var.managed_policies :
    policy.arn => policy
    if policy.type == "AWS_MANAGED"
  }


  instance_arn       = aws_ssoadmin_permission_set.this.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.this.arn

  managed_policy_arn = each.key
}

resource "aws_ssoadmin_customer_managed_policy_attachment" "this" {
  for_each = {
    for policy in var.managed_policies :
    "${policy.path}/${policy.name}" => policy
    if policy.type == "CUSTOMER_MANAGED"
  }

  instance_arn       = aws_ssoadmin_permission_set.this.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.this.arn

  customer_managed_policy_reference {
    name = each.value.name
    path = each.value.path
  }
}


###################################################
# Inline Policy
###################################################

resource "aws_ssoadmin_permission_set_inline_policy" "this" {
  count = var.inline_policy != null ? 1 : 0

  instance_arn       = aws_ssoadmin_permission_set.this.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.this.arn
  inline_policy      = var.inline_policy
}


###################################################
# Permissions Boundary Policy
###################################################

resource "aws_ssoadmin_permissions_boundary_attachment" "this" {
  count = var.permissions_boundary != null ? 1 : 0

  instance_arn       = aws_ssoadmin_permission_set.this.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.this.arn

  dynamic "permissions_boundary" {
    for_each = var.permissions_boundary.type == "CUSTOMER_MANAGED" ? [var.permissions_boundary] : []

    content {
      customer_managed_policy_reference {
        name = permissions_boundary.value.name
        path = permissions_boundary.value.path
      }
    }
  }

  dynamic "permissions_boundary" {
    for_each = var.permissions_boundary.type == "AWS_MANAGED" ? [var.permissions_boundary] : []

    content {
      managed_policy_arn = permissions_boundary.value.arn
    }
  }
}
