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
  service_linked_roles = {
    "eks.amazonaws.com" = {
      service = "dashboard.eks.amazonaws.com"
      name    = "AWSServiceRoleForAmazonEKSDashboard"
    }
  }
  individual_trusted_accesses = toset([
    # INFO: Using the IPAM `EnableIpamOrganizationAdminAccount` API, automatically grant trusted access to IPAM
    "ipam.amazonaws.com",
    "notifications.amazon.com",
    "ram.amazonaws.com",
    "servicecatalog.amazonaws.com",
    "servicequotas.amazonaws.com",
    # INFO: Use the Well Architected Tool `update-global-settings` API
    "wellarchitected.amazonaws.com",
  ])
  # INFO: confirmed service principals
  # - `access-analyzer.amazonaws.com`
  # - `account.amazonaws.com`
  # - `auditmanager.amazonaws.com`
  # - `aws-artifact-account-sync.amazonaws.com`
  # - `billing-cost-management.amazonaws.com`
  # - `cloudtrail.amazonaws.com`
  # - `compute-optimizer.amazonaws.com`
  # - `config.amazonaws.com`
  # - `config-multiaccountsetup.amazonaws.com`
  # - `cost-optimization-hub.bcm.amazonaws.com`
  # - `detective.amazonaws.com`
  # - `eks.amazonaws.com`
  # - `fms.amazonaws.com`
  # - `health.amazonaws.com`
  # - `inspector2.amazonaws.com`
  # - `macie.amazonaws.com`
  # - `reporting.trustedadvisor.amazonaws.com`
  # - `resource-explorer-2.amazonaws.com`
  # - `securityhub.amazonaws.com`
  # - `ssm.amazonaws.com`
  # - `sso.amazonaws.com`
  # - `storage-lens.s3.amazonaws.com`
  # - `tagpolicies.tag.amazonaws.com`
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

  # aws_service_access_principals = local.organization_managed_trusted_accesses
  aws_service_access_principals = var.trusted_access_enabled_service_principals

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

  depends_on = [
    aws_ram_sharing_with_organization.this,
    aws_servicecatalog_organizations_access.this,
    aws_servicequotas_template_association.this,
  ]
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

resource "aws_notifications_organizations_access" "this" {
  count = contains(var.trusted_access_enabled_service_principals, "notifications.amazon.com") ? 1 : 0

  enabled = true
}

resource "aws_ram_sharing_with_organization" "this" {
  count = contains(var.trusted_access_enabled_service_principals, "ram.amazonaws.com") ? 1 : 0
}

resource "aws_servicecatalog_organizations_access" "this" {
  count = contains(var.trusted_access_enabled_service_principals, "servicecatalog.amazonaws.com") ? 1 : 0

  enabled = true
}

resource "aws_servicequotas_template_association" "this" {
  count = contains(var.trusted_access_enabled_service_principals, "servicequotas.amazonaws.com") ? 1 : 0

  skip_destroy = false
}


###################################################
# Service-linked IAM Roles
###################################################

module "service_linked_role" {
  source  = "tedilabs/account/aws//modules/iam-service-linked-role"
  version = "~> 0.33.0"

  for_each = {
    for service_principal, role in local.service_linked_roles :
    service_principal => role
    if contains(var.trusted_access_enabled_service_principals, service_principal)
  }

  aws_service         = each.value.service
  description         = "Service-linked role for ${each.key} created by Terraform."
  module_tags_enabled = false

  tags = merge(
    {
      "Name" = each.value.name
    },
    local.module_tags,
    var.tags,
  )
}
