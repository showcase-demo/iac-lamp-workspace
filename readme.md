## Requirements

| Name | Version |
|------|---------|
| terraform | >= v1.1.8 |
| ibm | >=1.26.0 |

## Providers

| Name | Version |
|------|---------|
| ibm | 1.49.0 |

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
| region | リージョン | `string` | `"jp-tok"` | no |
| resource\_group\_name | リソースグループ名 | `string` | `"Default"` | no |
| security\_group\_name | セキュリティ・グループ名 | `string` | `"lamp-sg"` | no |
| allow\_ips | ログイン端末IPアドレス | `string` | `"10.1.1.0/24"` | no |
| vpc\_name | VPC名 | `string` | `"dev-vpc"` | no |
| tags | タグ名 | `list(string)` | ```[ "terraform" ]``` | no |
| ssh\_key\_name | sshキー名 | `string` | `"takamura-key"` | no |
| instance\_name | インスタンス名 | `string` | `"lamp-server"` | no |
| image\_name | OSイメージ名 | `string` | `"ibm-centos-7-9-minimal-amd64-8"` | no |
| profile | profile名 | `string` | `"bx2-2x8"` | no |
| webapp\_git\_url | webアプリのURL | `string` | `"https://github.com/showcase-demo/iac-lamp-app.git"` | no |
| logdna\_instance\_name | Log Analysisのインスタンス名 | `string` | `"dev-log-analysis-jp-tok"` | no |
| logdna\_service\_type | サービスタイプ (Log Analysis) | `string` | `"logdna"` | no |
| logdna\_plan | Log Analysisのサービスプラン | `string` | `"7-day"` | no |
| logdna\_default\_receiver | プラットフォーム・メトリックの有効化 | `bool` | `false` | no |
| logdna\_key\_name | Log Analysisのサービスキー名 | `string` | `"dev-logging-tf-instance-key"` | no |
| monitoring\_instance\_name | Cloud Monitoringのインスタンス名 | `string` | `"dev-monitoring-jp-tok"` | no |
| monitoring\_service\_type | サービスタイプ (Cloud Monitoring) | `string` | `"sysdig-monitor"` | no |
| monitoring\_plan | Cloud Monitoringのサービスプラン | `string` | `"graduated-tier"` | no |
| monitoring\_default\_receiver | プラットフォーム・メトリックの有効化 | `bool` | `false` | no |
| monitoring\_key\_name | Cloud Monitoringのサービスキー名 | `string` | `"dev-monitoring-tf-instance-key"` | no |

## Outputs

| Name | Description |
|------|-------------|
| region | n/a |
| resource\_group\_name | n/a |
| vpc\_id | n/a |
| logdna\_ingestion\_key | n/a |
| monitoring\_access\_key | n/a |
