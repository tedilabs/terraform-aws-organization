locals {
  independent_services = [
    "auditmanager.amazonaws.com",
    "cloudtrail.amazonaws.com",
    "detective.amazonaws.com",
    "fms.amazonaws.com",
    "guardduty.amazonaws.com",
    "inspector2.amazonaws.com",
    "ipam.amazonaws.com",
    "macie.amazonaws.com",
    "securityhub.amazonaws.com",
  ]
  regional_services = [
    "guardduty.amazonaws.com",
    "inspector2.amazonaws.com",
    "macie.amazonaws.com",
  ]

  # Transform delegated_services to a map for easier lookup
  delegated_services_map = {
    for service in var.delegated_services :
    service.name => service
  }

  delegated_service_names = var.delegated_services[*].name
}


###################################################
# Delegated Administrators for Organization Account
###################################################

# INFO: confirmed service principals
# - `access-analyzer.amazonaws.com`
# - `account.amazonaws.com`
# - `compute-optimizer.amazonaws.com`
# - `config.amazonaws.com`
# - `config-multiaccountsetup.amazonaws.com`
# - `cost-optimization-hub.bcm.amazonaws.com`
# - `health.amazonaws.com`
# - `reporting.trustedadvisor.amazonaws.com`
# - `resource-explorer-2.amazonaws.com`
# - `sso.amazonaws.com`
# - `storage-lens.s3.amazonaws.com`
resource "aws_organizations_delegated_administrator" "this" {
  for_each = toset([
    for service_name in local.delegated_service_names :
    service_name
    if !contains(local.independent_services, service_name)
  ])

  account_id        = aws_organizations_account.this.id
  service_principal = each.key
}

resource "aws_auditmanager_organization_admin_account_registration" "this" {
  count = contains(local.delegated_service_names, "auditmanager.amazonaws.com") ? 1 : 0

  admin_account_id = aws_organizations_account.this.id
}

resource "aws_cloudtrail_organization_delegated_admin_account" "this" {
  count = contains(local.delegated_service_names, "cloudtrail.amazonaws.com") ? 1 : 0

  account_id = aws_organizations_account.this.id
}

resource "aws_detective_organization_admin_account" "this" {
  count = contains(local.delegated_service_names, "detective.amazonaws.com") ? 1 : 0

  account_id = aws_organizations_account.this.id
}

resource "aws_fms_admin_account" "this" {
  count = contains(local.delegated_service_names, "fms.amazonaws.com") ? 1 : 0

  account_id = aws_organizations_account.this.id
}

resource "aws_securityhub_organization_admin_account" "this" {
  count = contains(local.delegated_service_names, "securityhub.amazonaws.com") ? 1 : 0

  admin_account_id = aws_organizations_account.this.id
}

resource "aws_vpc_ipam_organization_admin_account" "this" {
  count = contains(local.delegated_service_names, "ipam.amazonaws.com") ? 1 : 0

  delegated_admin_account_id = aws_organizations_account.this.id
}

resource "aws_guardduty_organization_admin_account" "this" {
  for_each = toset(contains(local.delegated_service_names, "guardduty.amazonaws.com")
    ? (length(local.delegated_services_map["guardduty.amazonaws.com"].regions) > 0
      ? local.delegated_services_map["guardduty.amazonaws.com"].regions
      : local.all_available_regions
    )
    : []
  )

  region = each.key

  admin_account_id = aws_organizations_account.this.id
}

resource "aws_macie2_organization_admin_account" "this" {
  for_each = toset(contains(local.delegated_service_names, "macie.amazonaws.com")
    ? (length(local.delegated_services_map["macie.amazonaws.com"].regions) > 0
      ? local.delegated_services_map["macie.amazonaws.com"].regions
      : local.all_available_regions
    )
    : []
  )

  region = each.key

  admin_account_id = aws_organizations_account.this.id
}

resource "aws_inspector2_delegated_admin_account" "this" {
  for_each = toset(contains(local.delegated_service_names, "inspector2.amazonaws.com")
    ? (length(local.delegated_services_map["inspector2.amazonaws.com"].regions) > 0
      ? local.delegated_services_map["inspector2.amazonaws.com"].regions
      : local.all_available_regions
    )
    : []
  )

  region = each.key

  account_id = aws_organizations_account.this.id
}
