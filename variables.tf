/******************************************
 Provider
 *****************************************/
# variable "ibmcloud_api_key" {
#   sensitive = true
# }

variable "region" {
  type        = string
  default     = "jp-tok"
  description = "リージョン"
}

/******************************************
 Resource Group, Tags
 *****************************************/
variable "resource_group_name" {
  default     = "demo-common"
  description = "リソースグループ名"
}

variable "tags" {
  type        = list(string)
  default     = ["terraform"]
  description = "タグ名"
}

#variable "ssh_key_names" {
#  type    = list(string)
#  default = ["takamura-key", "satokota-key", "nfumie-key"]
#  description = "sshキー名のリスト"
#}

variable "ssh_key_name" {
  type    = string
  default = "takamura-key"
  description = "sshキー名"
}
/******************************************
 VPC
 *****************************************/
variable "vpc_name" {
  type        = string
  default     = "iac-vpc"
  description = "VPC名"
}


/******************************************
 VSI
 *****************************************/
# image names can be determined with the cli command `ibmcloud is images`
variable "image_name" {
  description = "OSイメージ名"
  default     = "ibm-centos-7-9-minimal-amd64-8"
}


/******************************************
 Log Analysis
 *****************************************/
variable "logdna_name" {
  type = string
  default = "iac-log-analysis"
  description = "Log Analysisのインスタンス名"
}

variable "logdna_service_type" {
  type = string
  default = "logdna"
  description = "サービスタイプ (Log Analysis)"
}

variable "logdna_plan" {
  type = string
  default = "7-day"
  description = "Log Analysisのサービスプラン"
}

variable "logdna_default_receiver" {
  type = bool
  default = false
  description = "プラットフォーム・メトリックの有効化"
}

variable "logdna_location" {
  type = string
  default = "jp-tok"
  description = "Log Analysisのロケーション"
}

variable "logdna_key_name" {
  type = string
  default = "iac-logging-tf-instance-key"
  description = "Log Analysisのサービスキー名"
}


/******************************************
 IBM Monitoring
 *****************************************/
variable "monitoring_service_type" {
  type = string
  default = "sysdig-monitor"
  description = "サービスタイプ (Cloud Monitoring)"
}

variable "monitoring_name" {
  type = string
  default = "iac-monitoring"
  description = "Cloud Monitoringのインスタンス名"
}

variable "monitoring_plan" {
  type = string
  default = "graduated-tier"
  description = "Cloud Monitoringのサービスプラン"
}

variable "monitoring_default_receiver" {
  type = bool
  default = false
  description = "プラットフォーム・メトリックの有効化"
}

variable "monitoring_location" {
  type = string
  default = "jp-tok"
  description = "Cloud Monitoringのロケーション"
}

variable "monitoring_key_name" {
  type = string
  default = "iac-monitoring-tf-instance-key"
  description = "Cloud Monitoringのサービスキー名"
}

