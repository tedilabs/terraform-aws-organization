# terraform-aws-organization

![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/tedilabs/terraform-aws-organization?color=blue&sort=semver&style=flat-square)
![GitHub](https://img.shields.io/github/license/tedilabs/terraform-aws-organization?color=blue&style=flat-square)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white&style=flat-square)](https://github.com/pre-commit/pre-commit)

Terraform modules to manage Organization related resources on AWS.

- [account](./modules/account)
- [organization](./modules/organization)
- [organizational-unit](./modules/organizational-unit)
- [ram-share](./modules/ram-share)
- [sso-access-control-attributes](./modules/sso-access-control-attributes)
- [sso-account-assignment](./modules/sso-account-assignment)
- [sso-permission-set](./modules/sso-permission-set)


## Target AWS Services

Terraform Modules from [this package](https://github.com/tedilabs/terraform-aws-organization) were written to manage the following AWS Services with Terraform.

- **AWS IAM Identity Center (AWS SSO)**
  - Access Control Attributes
  - Account Assignment
  - Permission Set
- **AWS Organization**
  - Organization
  - Organization Unit
  - Account
- **AWS RAM (Resource Access Manager)**
  - Share


## Other Terraform Modules from Tedilabs

Enjoying [terraform-aws-organization](https://github.com/tedilabs/terraform-aws-organization)? Check out some of our other modules:

- [AWS Container](https://github.com/tedilabs/terraform-aws-container) - A package of Terraform Modules to manage AWS Container resources.
- [AWS Domain](https://github.com/tedilabs/terraform-aws-domain) - A package of Terraform Modules to manage AWS Domain resources.
- [AWS Load Balancer](https://github.com/tedilabs/terraform-aws-load-balancer) - A package of Terraform Modules to manage AWS Load Balancer resources.
- [AWS Network](https://github.com/tedilabs/terraform-aws-network) - A package of Terraform Modules to manage AWS Network resources.
- [AWS Security](https://github.com/tedilabs/terraform-aws-security) - A package of Terraform Modules to manage AWS Security resources.

Or check out [the full list](https://github.com/search?q=org%3Atedilabs+topic%3Aterraform-module&type=repositories)


## Self Promotion

Like this project? Follow the repository on [GitHub](https://github.com/tedilabs/terraform-aws-organization). And if you're feeling especially charitable, follow **[posquit0](https://github.com/posquit0)** on GitHub.


## License

Provided under the terms of the [Apache License](LICENSE).

Copyright © 2024-2025, [Byungjin Park](https://www.posquit0.com).
