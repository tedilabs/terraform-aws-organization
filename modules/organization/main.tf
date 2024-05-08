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

locals {
  individual_trusted_accesses = toset([
    "ram.amazonaws.com",
    "servicecatalog.amazonaws.com",
  ])
  # INFO: confirmed service principals
  # - `access-analyzer.amazonaws.com`
  # - `account.amazonaws.com`
  # - `auditmanager.amazonaws.com`
  # - `cloudtrail.amazonaws.com`
  # - `config.amazonaws.com`
  # - `config-multiaccountsetup.amazonaws.com`
  # - `cost-optimization-hub.bcm.amazonaws.com`
  # - `detective.amazonaws.com`
  # - `macie.amazonaws.com`
  # - `resource-explorer-2.amazonaws.com`
  # - `securityhub.amazonaws.com`
  # - `sso.amazonaws.com`
  organization_managed_trusted_accesses = setsubtract(
    var.trusted_access_enabled_service_principals,
    local.individual_trusted_accesses
  )
}


###################################################
# Organization
###################################################

resource "aws_organizations_organization" "this" {
  feature_set          = var.all_features_enabled ? "ALL" : "CONSOLIDATED_BILLING"
  enabled_policy_types = var.enabled_policy_types

  aws_service_access_principals = local.organization_managed_trusted_accesses

  lifecycle {
    precondition {
      condition     = !(length(var.trusted_access_enabled_service_principals) > 0) || var.all_features_enabled
      error_message = "Trusted Accesses must be enabled when all features are enabled."
    }
    precondition {
      condition     = !(length(var.enabled_policy_types) > 0) || var.all_features_enabled
      error_message = "Policy Types must be enabled when all features are enabled."
    }
  }
}


###################################################
# AWS Managed Policies
###################################################

resource "aws_organizations_policy_attachment" "this" {
  for_each = toset(var.policies)

  target_id = aws_organizations_organization.this.roots[0].id
  policy_id = each.key

  skip_destroy = false
}


###################################################
# Individual Trusted Accesses
###################################################

resource "aws_ram_sharing_with_organization" "this" {
  count = contains(var.trusted_access_enabled_service_principals, "ram.amazonaws.com") ? 1 : 0
}

resource "aws_servicecatalog_organizations_access" "this" {
  count = contains(var.trusted_access_enabled_service_principals, "servicecatalog.amazonaws.com") ? 1 : 0

  enabled = true
}
