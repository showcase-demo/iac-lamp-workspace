/******************************************
 Provider
 *****************************************/
variable "ibmcloud_api_key" {
  sensitive = true
}

variable "region" {
  type        = string
  default     = "jp-tok"
  description = "Region"
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

variable "ssh_name" {
  type        = string
  default     = "takamura-key"
  description = "sshキー名"
}
/******************************************
 VPC
 *****************************************/
variable "vpc_name" {
  type        = string
  default     = "iac-vpc"
  description = "vpc名"
}


/******************************************
 VSI
 *****************************************/
# image names can be determined with the cli command `ibmcloud is images`
variable "image_name" {
  description = "OS image for VSI deployments. Only tested with Centos"
  default     = "ibm-centos-7-9-minimal-amd64-8"
}


/******************************************
 Log Analysis
 *****************************************/
variable "log_name" {
  description = "name of log instance"
  type = string
  default = "iac-log-analysis"
}

variable "log_service_type" {
  description = "Type of resource instance"
  type = string
  default = "logdna"
}

variable "log_plan" {
  description = "Type of service plan."
  type = string
  default = "7-day"
}

variable "log_default_receiver" {
  description = "Flag to select the instance to collect platform logs"
  type = bool
  default = false
}

variable "log_location" {
  description = "Location where the resource is provisioned"
  type = string
  default = "jp-tok"
}

variable "log_key_name" {
  description = "Name of the resource key associated with the instance"
  type = string
  default = "iac-logging-tf-instance-key"
}


/******************************************
 IBM Monitoring
 *****************************************/
 variable "monitoring_service_type" {
  description = "Type of resource instance"
  type = string
  default = "sysdig-monitor"
}

variable "monitoring_plan" {
  description = "Type of service plan."
  type = string
  default = "graduated-tier"
}

variable "monitoring_default_receiver" {
  description = "Flag to select the instance to collect platform metrics"
  type = bool
  default = false
}

variable "monitoring_location" {
  description = "Location where the resource is provisioned"
  type = string
  default = "jp-tok"
}

variable "monitoring_name" {
  description = "Name of the resource instance"
  type = string
  default = "iac-monitoring"
}

variable "monitoring_key_name" {
  description = "Name of the resource key associated with the instance"
  type = string
  default = "iac-monitoring-tf-instance-key"
}

