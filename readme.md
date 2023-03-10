## Requirements

| Name | Version |
|------|---------|
| terraform | >= v1.1.8 |
| ibm | >=1.26.0 |

## Providers

| Name | Version |
|------|---------|
| ibm | 1.50.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [ibm_is_floating_ip.lamp_server_fip](https://registry.terraform.io/providers/ibm-cloud/ibm/latest/docs/resources/is_floating_ip) | resource |
| [ibm_is_instance.lamp_server](https://registry.terraform.io/providers/ibm-cloud/ibm/latest/docs/resources/is_instance) | resource |
| [ibm_is_public_gateway.pgw_vpc_zone1](https://registry.terraform.io/providers/ibm-cloud/ibm/latest/docs/resources/is_public_gateway) | resource |
| [ibm_is_security_group.lamp_sg](https://registry.terraform.io/providers/ibm-cloud/ibm/latest/docs/resources/is_security_group) | resource |
| [ibm_is_security_group_rule.allow_monitoring](https://registry.terraform.io/providers/ibm-cloud/ibm/latest/docs/resources/is_security_group_rule) | resource |
| [ibm_is_security_group_rule.https_from_all](https://registry.terraform.io/providers/ibm-cloud/ibm/latest/docs/resources/is_security_group_rule) | resource |
| [ibm_is_security_group_rule.icmp_all](https://registry.terraform.io/providers/ibm-cloud/ibm/latest/docs/resources/is_security_group_rule) | resource |
| [ibm_is_security_group_rule.outpound_all](https://registry.terraform.io/providers/ibm-cloud/ibm/latest/docs/resources/is_security_group_rule) | resource |
| [ibm_is_security_group_rule.ssh_from_satellite](https://registry.terraform.io/providers/ibm-cloud/ibm/latest/docs/resources/is_security_group_rule) | resource |
| [ibm_is_subnet.subnet_zone1](https://registry.terraform.io/providers/ibm-cloud/ibm/latest/docs/resources/is_subnet) | resource |
| [ibm_is_subnet_public_gateway_attachment.pgw_attach](https://registry.terraform.io/providers/ibm-cloud/ibm/latest/docs/resources/is_subnet_public_gateway_attachment) | resource |
| [ibm_is_vpc.vpc](https://registry.terraform.io/providers/ibm-cloud/ibm/latest/docs/resources/is_vpc) | resource |
| [ibm_is_vpc_address_prefix.prefix_zone1](https://registry.terraform.io/providers/ibm-cloud/ibm/latest/docs/resources/is_vpc_address_prefix) | resource |
| [ibm_resource_instance.logdna](https://registry.terraform.io/providers/ibm-cloud/ibm/latest/docs/resources/resource_instance) | resource |
| [ibm_resource_instance.monitoring_instance](https://registry.terraform.io/providers/ibm-cloud/ibm/latest/docs/resources/resource_instance) | resource |
| [ibm_resource_key.logdna_resource_key](https://registry.terraform.io/providers/ibm-cloud/ibm/latest/docs/resources/resource_key) | resource |
| [ibm_resource_key.monitoring_resource_key](https://registry.terraform.io/providers/ibm-cloud/ibm/latest/docs/resources/resource_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| region | ??????????????? | `string` | `"jp-tok"` | no |
| resource\_group\_name | ??????????????????????????? | `string` | `"Default"` | no |
| security\_group\_name | ???????????????????????????????????? | `string` | `"lamp-sg"` | no |
| allow\_ips | SSH??????????????????IP???????????? | `string` | `"10.0.1.0/24"` | no |
| vpc\_name | VPC??? | `string` | `"dev-vpc"` | no |
| tags | ????????? | `list(string)` | ```[ "terraform" ]``` | no |
| ssh\_key\_names | ssh????????????????????? | `list(string)` | ```[ "takamura-key", "satokota-key" ]``` | no |
| instance\_name | ????????????????????? | `string` | `"lamp-server"` | no |
| image\_name | OS??????????????? | `string` | `"ibm-centos-7-9-minimal-amd64-8"` | no |
| profile | profile??? | `string` | `"bx2-2x8"` | no |
| webapp\_git\_url | web????????????URL | `string` | `"https://github.com/showcase-demo/iac-lamp-app.git"` | no |
| logdna\_instance\_name | Log Analysis???????????????????????? | `string` | `"dev-log-analysis-jp-tok"` | no |
| logdna\_plan | Log Analysis???????????????????????? | `string` | `"7-day"` | no |
| monitoring\_instance\_name | Cloud Monitoring???????????????????????? | `string` | `"dev-monitoring-jp-tok"` | no |
| monitoring\_plan | Cloud Monitoring???????????????????????? | `string` | `"graduated-tier"` | no |

## Outputs

| Name | Description |
|------|-------------|
| region | n/a |
| resource\_group\_name | n/a |
| vpc\_id | n/a |
| logdna\_ingestion\_key | n/a |
| monitoring\_access\_key | n/a |
