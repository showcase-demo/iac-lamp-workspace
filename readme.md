## Requirements

| Name | Version |
|------|---------|
| terraform | >= v1.1.8 |
| ibm | >=1.26.0 |

## Providers

| Name | Version |
|------|---------|
| ibm | 1.49.0 |
| template | 2.2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [ibm_iam_user_policy.logdna_policy](https://registry.terraform.io/providers/ibm-cloud/ibm/latest/docs/resources/iam_user_policy) | resource |
| [ibm_iam_user_policy.monitoring_policy](https://registry.terraform.io/providers/ibm-cloud/ibm/latest/docs/resources/iam_user_policy) | resource |
| [ibm_is_floating_ip.lamp_server_fip](https://registry.terraform.io/providers/ibm-cloud/ibm/latest/docs/resources/is_floating_ip) | resource |
| [ibm_is_instance.lamp_server](https://registry.terraform.io/providers/ibm-cloud/ibm/latest/docs/resources/is_instance) | resource |
| [ibm_is_public_gateway.pgw_vpc_zone1](https://registry.terraform.io/providers/ibm-cloud/ibm/latest/docs/resources/is_public_gateway) | resource |
| [ibm_is_security_group.lamp_sg](https://registry.terraform.io/providers/ibm-cloud/ibm/latest/docs/resources/is_security_group) | resource |
| [ibm_is_security_group_rule.allow_monitoring](https://registry.terraform.io/providers/ibm-cloud/ibm/latest/docs/resources/is_security_group_rule) | resource |
| [ibm_is_security_group_rule.https_from_all](https://registry.terraform.io/providers/ibm-cloud/ibm/latest/docs/resources/is_security_group_rule) | resource |
| [ibm_is_security_group_rule.icmp_all](https://registry.terraform.io/providers/ibm-cloud/ibm/latest/docs/resources/is_security_group_rule) | resource |
| [ibm_is_security_group_rule.outpound_all](https://registry.terraform.io/providers/ibm-cloud/ibm/latest/docs/resources/is_security_group_rule) | resource |
| [ibm_is_security_group_rule.ssh_from_home](https://registry.terraform.io/providers/ibm-cloud/ibm/latest/docs/resources/is_security_group_rule) | resource |
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
| region | リージョン | `string` | `"jp-tok"` | no |
| resource\_group\_name | リソースグループ名 | `string` | `"demo-common"` | no |
| vpc\_name | VPC名 | `string` | `"iac-vpc"` | no |
| tags | タグ名 | `list(string)` | ```[ "terraform" ]``` | no |
| ssh\_key\_name | sshキー名 | `string` | `"takamura-key"` | no |
| image\_name | OSイメージ名 | `string` | `"ibm-centos-7-9-minimal-amd64-8"` | no |
| logdna\_name | Log Analysisのインスタンス名 | `string` | `"iac-log-analysis"` | no |
| logdna\_service\_type | サービスタイプ (Log Analysis) | `string` | `"logdna"` | no |
| logdna\_plan | Log Analysisのサービスプラン | `string` | `"7-day"` | no |
| logdna\_default\_receiver | プラットフォーム・メトリックの有効化 | `bool` | `false` | no |
| logdna\_location | Log Analysisのロケーション | `string` | `"jp-tok"` | no |
| logdna\_key\_name | Log Analysisのサービスキー名 | `string` | `"iac-logging-tf-instance-key"` | no |
| monitoring\_service\_type | サービスタイプ (Cloud Monitoring) | `string` | `"sysdig-monitor"` | no |
| monitoring\_name | Cloud Monitoringのインスタンス名 | `string` | `"iac-monitoring"` | no |
| monitoring\_plan | Cloud Monitoringのサービスプラン | `string` | `"graduated-tier"` | no |
| monitoring\_default\_receiver | プラットフォーム・メトリックの有効化 | `bool` | `false` | no |
| monitoring\_location | Cloud Monitoringのロケーション | `string` | `"jp-tok"` | no |
| monitoring\_key\_name | Cloud Monitoringのサービスキー名 | `string` | `"iac-monitoring-tf-instance-key"` | no |

## Outputs

| Name | Description |
|------|-------------|
| region | n/a |
| resource\_group\_name | n/a |
| vpc\_id | n/a |
| logdna\_ingestion\_key | n/a |
| monitoring\_access\_key | n/a |
| user\_data | n/a |
