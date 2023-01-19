/******************************************
 Resource Group
 *****************************************/
data "ibm_resource_group" "demo" {
  name = var.resource_group_name
}

/******************************************
 VPC
 *****************************************/
resource "ibm_is_vpc" "vpc" {
  name           = var.vpc_name
  resource_group = data.ibm_resource_group.demo.id
  tags           = var.tags
}

/******************************************
 Subnet
 *****************************************/
resource "ibm_is_vpc_address_prefix" "prefix_zone1" {
  cidr = "10.0.1.0/24"
  name = format("%s-add-prefix-zone1", var.vpc_name)
  vpc  = ibm_is_vpc.vpc.id
  zone = format("%s-1", var.region) # jp-tok-1
}

resource "ibm_is_subnet" "subnet_zone1" {
  depends_on = [
    ibm_is_vpc_address_prefix.prefix_zone1
  ]
  ipv4_cidr_block = "10.0.1.0/24"
  name            = format("%s-subnet-zone1", var.vpc_name)
  resource_group  = data.ibm_resource_group.demo.id
  vpc  = ibm_is_vpc.vpc.id
  zone = format("%s-1", var.region) # jp-tok-1
}

/******************************************
 Public gateway
 *****************************************/
 resource "ibm_is_public_gateway" "pgw_vpc_zone1" {
  name = "public-gateway-zone1"  ##############################
  vpc  = ibm_is_vpc.vpc.id
  zone = format("%s-1", var.region) # jp-tok-1
  resource_group = data.ibm_resource_group.demo.id
}

resource "ibm_is_subnet_public_gateway_attachment" "pgw_attach" {
  subnet                = ibm_is_subnet.subnet_zone1.id
  public_gateway         = ibm_is_public_gateway.pgw_vpc_zone1.id
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
# data "ibm_is_ssh_keys" "ssh_keys" {
# }

data "ibm_is_ssh_key" "takamura_key" {
  name = var.ssh_key_name
}

/******************************************
 user data
 *****************************************/
data "template_file" "lamp_install" {
  template = "${file("install.yaml")}"
  vars = {
    logdna_ingestion_key = ibm_resource_key.logdna_resource_key.credentials["ingestion_key"]
    monitoring_access_key = ibm_resource_key.monitoring_resource_key.credentials["Sysdig Access Key"]
  }
}

/******************************************
 Security group
 *****************************************/
resource "ibm_is_security_group" "lamp_sg" {
  name = "security-group-iac"              ###################
  vpc  = ibm_is_vpc.vpc.id
  resource_group = data.ibm_resource_group.demo.id
}

resource "ibm_is_security_group_rule" "icmp_all" {
  group     = ibm_is_security_group.lamp_sg.id
  direction = "inbound"
  icmp {
  }
}

resource "ibm_is_security_group_rule" "outpound_all" {
  group     = ibm_is_security_group.lamp_sg.id
  direction = "outbound"
}

resource "ibm_is_security_group_rule" "ssh_from_home" {
  group     = ibm_is_security_group.lamp_sg.id
  direction = "inbound"
  remote    = "219.110.209.185"
  tcp {
    port_min = 22
    port_max = 22
  }
}

resource "ibm_is_security_group_rule" "ssh_from_satellite" {
  group     = ibm_is_security_group.lamp_sg.id
  direction = "inbound"
  remote    = "129.41.57.0/29"
  tcp {
    port_min = 22
    port_max = 22
  }
}

resource "ibm_is_security_group_rule" "https_from_all" {
  group     = ibm_is_security_group.lamp_sg.id
  direction = "inbound"
  tcp {
    port_min = 80
    port_max = 80
  }
}

resource "ibm_is_security_group_rule" "allow_monitoring" {
  group     = ibm_is_security_group.lamp_sg.id
  direction = "inbound"
  tcp {
    port_min = 6443
    port_max = 6443
  }
}
/******************************************
 VSI
 *****************************************/

resource "ibm_is_instance" "lamp_server" {
  name    = "iac-instance"                   ################
  vpc     = ibm_is_vpc.vpc.id
  zone    = format("%s-1", var.region)
  keys    = [data.ibm_is_ssh_key.takamura_key.id]
  image   = data.ibm_is_image.os.id
  profile = "bx2-2x8"
  metadata_service_enabled  = false
  user_data = "${data.template_file.lamp_install.rendered}"
  resource_group = data.ibm_resource_group.demo.id


  primary_network_interface {
    subnet = ibm_is_subnet.subnet_zone1.id
    # primary_ipv4_address = "10.0.1.4" 
    security_groups = [ibm_is_security_group.lamp_sg.id]
    allow_ip_spoofing = false
  }
}

resource "ibm_is_floating_ip" "lamp_server_fip" {
  name   = "lamp-server-fip"
  target = ibm_is_instance.lamp_server.primary_network_interface[0].id
  resource_group = data.ibm_resource_group.demo.id
}

/******************************************
 Log analysis
 *****************************************/
locals {
  logdna_name = "${var.logdna_name}-${var.logdna_location}"
}

resource "ibm_resource_instance" "logdna" {
  name = local.logdna_name
  service = var.logdna_service_type
  plan = var.logdna_plan
  # location = var.logdna_location
  location = var.region
  resource_group_id = data.ibm_resource_group.demo.id
  tags = ["logging", "public"]
  parameters = {
    default_receiver= var.logdna_default_receiver
  }
}

  // Create the resource key that is associated with the {{site.data.keyword.la_short}} instance

resource "ibm_resource_key" "logdna_resource_key" {
  name = var.logdna_key_name
  role = "Manager"
  resource_instance_id = ibm_resource_instance.logdna.id
}

  // Add a user policy for using the resource instance

resource "ibm_iam_user_policy" "logdna_policy" {
  ibm_id = "soh.takamura@ibm.com"
  roles  = ["Manager", "Viewer"]

  resources {
    service              = "logdna"
    resource_instance_id = element(split(":", ibm_resource_instance.logdna.id), 7)
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
  # location = var.monitoring_location
  location = var.region
  resource_group_id = data.ibm_resource_group.demo.id
  tags = ["monitoring", "public"]
  parameters = {
  default_receiver= var.monitoring_default_receiver
  }
}


resource "ibm_resource_key" "monitoring_resource_key" {
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
