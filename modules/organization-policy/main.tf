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
# Policy Content
###################################################

locals {
  templates = var.template != null ? yamldecode(file("${path.module}/templates.yaml")) : {}
  template  = var.template != null ? local.templates[var.type][var.template.name] : null

  policy_content = var.template != null ? terraform_data.policy[0].output : var.content
}

resource "terraform_data" "policy" {
  count = var.template != null ? 1 : 0

  input = jsonencode({
    Version = "2012-10-17"
    Statement = yamldecode(
      templatefile(
        "${path.module}/${local.template.file_path}",
        merge({
          for name, parameter in local.template.parameters.required :
          name => var.template.parameters[name]
          }, {
          for name, parameter in local.template.parameters.optional :
          name => try(var.template.parameters[name], parameter.default)
        })
      )
    )
  })

  lifecycle {
    precondition {
      condition     = var.content == null
      error_message = "Only one of `content` or `template` can be specified."
    }
    precondition {
      condition = alltrue([
        for parameter in local.template.parameters.required :
        contains(keys(var.template.parameters), parameter)
      ])
      error_message = "All required parameters (${join(", ", keys(local.template.parameters.required))}) must be provided in `parameters` for the selected template `${var.template.name}`."
    }
  }
}


###################################################
# Organization Policy
###################################################

resource "aws_organizations_policy" "this" {
  name = var.name
  description = (var.template != null
    ? coalesce(var.description, local.template.description)
    : var.description
  )
  skip_destroy = var.skip_destroy

  type    = var.type
  content = local.policy_content

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )
}
