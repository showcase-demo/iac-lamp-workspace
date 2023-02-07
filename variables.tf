/******************************************
 Provider
 *****************************************/
variable "region" {
  type        = string
  default     = "jp-tok"
  description = "リージョン"
}

/******************************************
 Resource Group
 *****************************************/
variable "resource_group_name" {
  default     = "Default"
  description = "リソースグループ名"
}

/******************************************
 Security Group
 *****************************************/
variable "security_group_name" {
  default     = "lamp-sg"
  description = "セキュリティ・グループ名"
}

variable "allow_ips" {
  default     = "10.1.1.0/24"
  description = "ログイン端末IPアドレス"
}
/******************************************
 VPC
 *****************************************/
variable "vpc_name" {
  type        = string
  default     = "dev-vpc"
  description = "VPC名"
}

/******************************************
 Tag, ssh
 *****************************************/
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
  type        = string
  default     = "takamura-key"
  description = "sshキー名"
}
/******************************************
 VSI
 *****************************************/
# image names can be determined with the cli command `ibmcloud is images`
variable "instance_name" {
  default     = "lamp-server"
  description = "インスタンス名"
}
variable "image_name" {
  default     = "ibm-centos-7-9-minimal-amd64-8"
  description = "OSイメージ名"
}

variable "profile" {
  default     = "bx2-2x8"
  description = "profile名"
}

variable "webapp_git_url" {
  default     = "https://github.com/showcase-demo/iac-lamp-app.git"
  description = "webアプリのURL"
}

/******************************************
 Log Analysis
 *****************************************/
variable "logdna_instance_name" {
  type        = string
  default     = "dev-log-analysis-jp-tok"
  description = "Log Analysisのインスタンス名"
}

variable "logdna_service_type" {
  type        = string
  default     = "logdna"
  description = "サービスタイプ (Log Analysis)"
}

variable "logdna_plan" {
  type        = string
  default     = "7-day"
  description = "Log Analysisのサービスプラン"
}

variable "logdna_default_receiver" {
  type        = bool
  default     = false
  description = "プラットフォーム・メトリックの有効化"
}

variable "logdna_key_name" {
  type        = string
  default     = "dev-logging-tf-instance-key"
  description = "Log Analysisのサービスキー名"
}

/******************************************
 IBM Monitoring
 *****************************************/
variable "monitoring_instance_name" {
  type        = string
  default     = "dev-monitoring-jp-tok"
  description = "Cloud Monitoringのインスタンス名"
}

variable "monitoring_service_type" {
  type        = string
  default     = "sysdig-monitor"
  description = "サービスタイプ (Cloud Monitoring)"
}

variable "monitoring_plan" {
  type        = string
  default     = "graduated-tier"
  description = "Cloud Monitoringのサービスプラン"
}

variable "monitoring_default_receiver" {
  type        = bool
  default     = false
  description = "プラットフォーム・メトリックの有効化"
}

variable "monitoring_key_name" {
  type        = string
  default     = "dev-monitoring-tf-instance-key"
  description = "Cloud Monitoringのサービスキー名"
}