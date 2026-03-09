provider "aws" {
  region = "us-east-1"
}


###################################################
# AWS Account
###################################################

module "scp" {
  source = "../../modules/organization-policy"

  name = "example"
  type = "SERVICE_CONTROL_POLICY"

  policies = [
    {
      type = "INLINE"
      content = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            Sid      = "DenyAllS3"
            Effect   = "Deny"
            Action   = "s3:*"
            Resource = "*"
          }
        ]
      })
    },
    {
      type = "TEMPLATE"
      template = {
        name = "s3/restrict-public-access-block-management"
        parameters = {
          permittedPrincipals = ["arn:aws:iam::*:role/allow-full-access"]
        }
      }
    }
  ]
}
