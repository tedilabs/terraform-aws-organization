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


###################################################
# Policy Content
###################################################

locals {
  templates = yamldecode(file("${path.module}/templates.yaml"))[var.type]
}

resource "terraform_data" "policies" {
  for_each = {
    for idx, policy in var.policies :
    idx => policy
  }

  input = (each.value.type == "TEMPLATE"
    ? jsonencode({
      Version = "2012-10-17"
      Statement = yamldecode(
        templatefile(
          "${path.module}/${local.templates[each.value.template.name].file_path}",
          merge(
            {
              for name, parameter in local.templates[each.value.template.name].parameters.required :
              name => each.value.template.parameters[name]
            },
            {
              for name, parameter in local.templates[each.value.template.name].parameters.optional :
              name => try(each.value.template.parameters[name], parameter.default)
            }
          )
        )
      )
    })
    : (each.value.type == "INLINE" ? each.value.content : "error")
  )

  lifecycle {
    precondition {
      condition = each.value.type != "TEMPLATE" || alltrue([
        for parameter in keys(local.templates[each.value.template.name].parameters.required) :
        contains(keys(each.value.template.parameters), parameter)
      ])
      error_message = "All required parameters must be provided in `parameters` for the selected template."
    }
  }
}

data "aws_iam_policy_document" "combined" {
  source_policy_documents = [
    for idx, policy in terraform_data.policies :
    policy.output
  ]
}


###################################################
# Organization Policy
###################################################

resource "aws_organizations_policy" "this" {
  name         = var.name
  description  = var.description
  skip_destroy = var.skip_destroy

  type    = var.type
  content = data.aws_iam_policy_document.combined.minified_json

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )
}
