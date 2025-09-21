locals {
  independent_services = [
    "auditmanager.amazonaws.com",
    "cloudtrail.amazonaws.com",
    "detective.amazonaws.com",
    "fms.amazonaws.com",
    "guardduty.amazonaws.com",
    "ipam.amazonaws.com",
    "securityhub.amazonaws.com",
  ]
  regional_services = [
    "inspector2.amazonaws.com",
    "macie.amazonaws.com",
  ]

  # Transform delegated_services to a map for easier lookup
  delegated_services_map = {
    for service in var.delegated_services :
    service.name => service
  }

  # Extract service names for compatibility with existing logic
  delegated_service_names = [
    for service in var.delegated_services :
    service.name
  ]
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
# - `health.amazonaws.com`
# - `reporting.trustedadvisor.amazonaws.com`
# - `resource-explorer-2.amazonaws.com`
# - `sso.amazonaws.com`
# - `storage-lens.s3.amazonaws.com`
resource "aws_organizations_delegated_administrator" "this" {
  for_each = toset([
    for service_name in local.delegated_service_names :
    service_name
    if !contains(local.independent_services, service_name) && !contains(local.regional_services, service_name)
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

resource "aws_guardduty_organization_admin_account" "this" {
  count = contains(local.delegated_service_names, "guardduty.amazonaws.com") ? 1 : 0

  admin_account_id = aws_organizations_account.this.id
}

resource "aws_securityhub_organization_admin_account" "this" {
  count = contains(local.delegated_service_names, "securityhub.amazonaws.com") ? 1 : 0

  admin_account_id = aws_organizations_account.this.id
}

resource "aws_vpc_ipam_organization_admin_account" "this" {
  count = contains(local.delegated_service_names, "ipam.amazonaws.com") ? 1 : 0

  delegated_admin_account_id = aws_organizations_account.this.id
}

# Macie2 delegated administrator (regional service)
resource "aws_macie2_organization_admin_account" "this" {
  for_each = contains(local.delegated_service_names, "macie.amazonaws.com") ? toset(
    length(local.delegated_services_map["macie.amazonaws.com"].regions) > 0
    ? local.delegated_services_map["macie.amazonaws.com"].regions
    : ["us-east-1"] # Default region for enablement, but can be configured for all regions
  ) : []

  admin_account_id = aws_organizations_account.this.id

  # Note: This resource enables Macie delegation per region
  # If regions is empty, we default to us-east-1 but the delegated account 
  # can enable Macie in additional regions as needed
}

# Inspector2 delegated administrator (regional service)
resource "aws_inspector2_delegated_admin_account" "this" {
  for_each = contains(local.delegated_service_names, "inspector2.amazonaws.com") ? toset(
    length(local.delegated_services_map["inspector2.amazonaws.com"].regions) > 0
    ? local.delegated_services_map["inspector2.amazonaws.com"].regions
    : ["us-east-1"] # Default region for enablement
  ) : []

  account_id = aws_organizations_account.this.id

  # Note: This resource enables Inspector2 delegation per region
  # If regions is empty, we default to us-east-1 but the delegated account
  # can enable Inspector2 in additional regions as needed
}
