/******************************************
 Resource Group
 *****************************************/
data "ibm_resource_group" "this" {
  name = var.resource_group_name
}


/******************************************
 VPC
 *****************************************/
resource "ibm_is_vpc" "vpc" {
  name           = var.vpc_name
  resource_group = data.ibm_resource_group.this.id
  tags           = var.tags
}


/******************************************
 Subnet
 *****************************************/
resource "ibm_is_vpc_address_prefix" "zone1" {
  cidr = "10.0.1.0/24"
  name = format("%s-add-prefix-zone1", var.vpc_name)
  vpc  = ibm_is_vpc.vpc.id
  zone = format("%s-1", var.region) # jp-tok-1
}

resource "ibm_is_subnet" "zone1" {
  depends_on = [
    ibm_is_vpc_address_prefix.zone1
  ]
  ipv4_cidr_block = "10.0.1.0/24"
  name            = format("%s-subnet-zone1", var.vpc_name)

  vpc  = ibm_is_vpc.vpc.id
  zone = format("%s-1", var.region) # jp-tok-1
}


/******************************************
 Image
 *****************************************/
data "ibm_is_image" "os" {
  name = var.image_name
}

/******************************************
 ssh
 *****************************************/
data "ibm_is_ssh_key" "takamura-key" {
  name = "takamura-key"
}



/******************************************
 Security group
 *****************************************/
resource "ibm_is_security_group" "iac-sg" {
  name = "security-group-iac"
  vpc  = ibm_is_vpc.vpc.id
}

resource "ibm_is_security_group_rule" "icmp" {
  group     = ibm_is_security_group.iac-sg.id
  direction = "inbound"
  icmp {
  }
}

resource "ibm_is_security_group_rule" "ssh" {
  group     = ibm_is_security_group.iac-sg.id
  direction = "inbound"
  remote    = "219.110.209.185"
  tcp {
    port_min = 22
    port_max = 22
  }
}
/******************************************
 VSI
 *****************************************/
resource "ibm_is_instance" "virtual_instance" {
  name    = "iac-instance"
  vpc     = ibm_is_vpc.vpc.id
  zone    = format("%s-1", var.region)
  keys    = [data.ibm_is_ssh_key.takamura-key.id]
  image   = data.ibm_is_image.os.id
  profile = "bx2-2x8"
  metadata_service_enabled  = false
  # default_trusted_profile_target   = var.default_trusted_profile_target
  user_data      = "install.yaml"
  # resource_group = var.resource_group_name


  primary_network_interface {
    subnet = ibm_is_subnet.zone1.id
    primary_ipv4_address = "10.0.1.4" 
    security_groups = [ibm_is_security_group.iac-sg.id]
    allow_ip_spoofing = false
  }
}

resource "ibm_is_floating_ip" "iac-fip" {
  name   = "iac-floating-ip"
  target = ibm_is_instance.virtual_instance.primary_network_interface[0].id
}

/* primary_ipv4_address deprecation
output "primary_ipv4_address" {
  value = ibm_is_instance.iac_instance.primary_network_interface.0.primary_ip.0.address // use this instead
}
*/

/******************************************
 Log analysis
 *****************************************/
locals {
  log_instance_name = "${var.log_name}-${var.log_location}"
}

resource "ibm_resource_instance" "log_instance" {
  name = local.log_instance_name
  service = var.log_service_type
  plan = var.log_plan
  location = var.log_location
  resource_group_id = data.ibm_resource_group.this.id
  tags = ["logging", "public"]
  parameters = {
    default_receiver= var.log_default_receiver
  }
}

  // Create the resource key that is associated with the {{site.data.keyword.la_short}} instance

resource "ibm_resource_key" "log_resourceKey" {
  name = var.log_key_name
  role = "Manager"
  resource_instance_id = ibm_resource_instance.log_instance.id
}

  // Add a user policy for using the resource instance

resource "ibm_iam_user_policy" "log_policy" {
  ibm_id = "soh.takamura@ibm.com"
  roles  = ["Manager", "Viewer"]

  resources {
    service              = "logdna"
    resource_instance_id = element(split(":", ibm_resource_instance.log_instance.id), 7)
  }
}


/******************************************
 IBM Monitoring
 *****************************************/
locals {
  monitoring_instance_name = "${var.monitoring_name}-${var.monitoring_location}"
}

resource "ibm_resource_instance" "monitoring_instance" {
  name = local.monitoring_instance_name
  service = var.monitoring_service_type
  plan = var.monitoring_plan
  location = var.monitoring_location
  resource_group_id = data.ibm_resource_group.this.id
  tags = ["monitoring", "public"]
  parameters = {
  default_receiver= var.monitoring_default_receiver
  }
}

 // Create the resource key that is associated with the {{site.data.keyword.mon_short}} instance

resource "ibm_resource_key" "monitoring_resourceKey" {
  name = var.monitoring_key_name
  role = "Manager"
  resource_instance_id = ibm_resource_instance.monitoring_instance.id
}

// Add a user policy for using the resource instance

resource "ibm_iam_user_policy" "monitoring_policy" {
  ibm_id = "soh.takamura@ibm.com"
  roles  = ["Manager", "Viewer"]

  resources {
    service              = "sysdig-monitor"
    resource_instance_id = element(split(":", ibm_resource_instance.monitoring_instance.id), 7)
  }
}
