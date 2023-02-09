/******************************************
 Resource Group
 *****************************************/
data "ibm_resource_group" "default" {
  name = var.resource_group_name
}

/******************************************
 VPC
 *****************************************/
resource "ibm_is_vpc" "vpc" {
  name           = var.vpc_name
  resource_group = data.ibm_resource_group.default.id
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
  resource_group  = data.ibm_resource_group.default.id
  vpc             = ibm_is_vpc.vpc.id
  zone            = format("%s-1", var.region) # jp-tok-1
}

/******************************************
 Public gateway
 *****************************************/
resource "ibm_is_public_gateway" "pgw_vpc_zone1" {
  name           = "public-gateway-zone1"
  vpc            = ibm_is_vpc.vpc.id
  zone           = format("%s-1", var.region) # jp-tok-1
  resource_group = data.ibm_resource_group.default.id
}

resource "ibm_is_subnet_public_gateway_attachment" "pgw_attach" {
  subnet         = ibm_is_subnet.subnet_zone1.id
  public_gateway = ibm_is_public_gateway.pgw_vpc_zone1.id
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
# ssh-key
data "ibm_is_ssh_key" "keys" {
  count = length(var.ssh_key_names)
  name  = var.ssh_key_names[count.index]
}

/******************************************
 Security group
 *****************************************/
resource "ibm_is_security_group" "lamp_sg" {
  name           = var.security_group_name
  vpc            = ibm_is_vpc.vpc.id
  resource_group = data.ibm_resource_group.default.id
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

resource "ibm_is_security_group_rule" "ssh_from_satellite" {
  group     = ibm_is_security_group.lamp_sg.id
  direction = "inbound"
  remote    = var.allow_ips
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

locals {
  provisioning_scropt = templatefile("${path.module}/install.yaml", { webapp_git_url = var.webapp_git_url, logdna_ingestion_key = ibm_resource_key.logdna_resource_key.credentials["ingestion_key"], monitoring_access_key = ibm_resource_key.monitoring_resource_key.credentials["Sysdig Access Key"] })
}

resource "ibm_is_instance" "lamp_server" {
  name                     = var.instance_name
  vpc                      = ibm_is_vpc.vpc.id
  zone                     = format("%s-1", var.region)
  keys                     = data.ibm_is_ssh_key.keys.*.id
  image                    = data.ibm_is_image.os.id
  profile                  = var.profile
  metadata_service_enabled = false
  user_data                = local.provisioning_scropt
  resource_group           = data.ibm_resource_group.default.id


  primary_network_interface {
    subnet            = ibm_is_subnet.subnet_zone1.id
    security_groups   = [ibm_is_security_group.lamp_sg.id]
    allow_ip_spoofing = false
  }
}

resource "ibm_is_floating_ip" "lamp_server_fip" {
  name           = format("%s-fip", var.instance_name)
  target         = ibm_is_instance.lamp_server.primary_network_interface[0].id
  resource_group = data.ibm_resource_group.default.id
}

/******************************************
 Log analysis
 *****************************************/
resource "ibm_resource_instance" "logdna" {
  name              = var.logdna_instance_name
  service           = "logdna"
  plan              = var.logdna_plan
  location          = var.region
  resource_group_id = data.ibm_resource_group.default.id
  tags              = ["logging", "public"]
  parameters = {
    default_receiver = false
  }
}

resource "ibm_resource_key" "logdna_resource_key" {
  name                 = format("%s-key", var.logdna_instance_name)
  role                 = "Manager"
  resource_instance_id = ibm_resource_instance.logdna.id
}


/******************************************
 IBM Monitoring
 *****************************************/
resource "ibm_resource_instance" "monitoring_instance" {
  name              = var.monitoring_instance_name
  service           = "sysdig-monitor"
  plan              = var.monitoring_plan
  location          = var.region
  resource_group_id = data.ibm_resource_group.default.id
  tags              = ["monitoring", "public"]
  parameters = {
    default_receiver = "false"
  }
}

resource "ibm_resource_key" "monitoring_resource_key" {
  name                 = format("%s-key", var.monitoring_instance_name)
  role                 = "Manager"
  resource_instance_id = ibm_resource_instance.monitoring_instance.id
}
