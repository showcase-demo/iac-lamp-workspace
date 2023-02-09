output "region" {
  value = var.region
}

output "resource_group_name" {
  value = var.resource_group_name
}

output "vpc_id" {
  value = ibm_is_vpc.vpc.id
}

output "vsi_fip" {
  value = ibm_is_floating_ip.lamp_server_fip.address
}

output "logdna_ingestion_key" {
  value     = ibm_resource_key.logdna_resource_key.credentials["ingestion_key"]
  sensitive = true
}

output "monitoring_access_key" {
  value     = ibm_resource_key.monitoring_resource_key.credentials["Sysdig Access Key"]
  sensitive = true
}

# output "provisioning_scropt" {
#   value     = local.provisioning_scropt
# }
