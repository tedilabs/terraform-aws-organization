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
    "inspector2.amazonaws.com",
    "macie.amazonaws.com",
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
    for service in var.delegated_services :
    service
    if !contains(local.independent_services, service)
  ])

  account_id        = aws_organizations_account.this.id
  service_principal = each.key
}

resource "aws_auditmanager_organization_admin_account_registration" "this" {
  count = contains(var.delegated_services, "auditmanager.amazonaws.com") ? 1 : 0

  admin_account_id = aws_organizations_account.this.id
}

resource "aws_cloudtrail_organization_delegated_admin_account" "this" {
  count = contains(var.delegated_services, "cloudtrail.amazonaws.com") ? 1 : 0

  account_id = aws_organizations_account.this.id
}

resource "aws_detective_organization_admin_account" "this" {
  count = contains(var.delegated_services, "detective.amazonaws.com") ? 1 : 0

  account_id = aws_organizations_account.this.id
}

resource "aws_fms_admin_account" "this" {
  count = contains(var.delegated_services, "fms.amazonaws.com") ? 1 : 0

  account_id = aws_organizations_account.this.id
}

resource "aws_guardduty_organization_admin_account" "this" {
  count = contains(var.delegated_services, "guardduty.amazonaws.com") ? 1 : 0

  admin_account_id = aws_organizations_account.this.id
}

resource "aws_securityhub_organization_admin_account" "this" {
  count = contains(var.delegated_services, "securityhub.amazonaws.com") ? 1 : 0

  admin_account_id = aws_organizations_account.this.id
}

resource "aws_vpc_ipam_organization_admin_account" "this" {
  count = contains(var.delegated_services, "ipam.amazonaws.com") ? 1 : 0

  delegated_admin_account_id = aws_organizations_account.this.id
}
