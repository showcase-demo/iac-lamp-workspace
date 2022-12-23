/******************************************
 Resource Group
 *****************************************/
data "ibm_resource_group" "this" {
  name = var.resource_group_name
}


/******************************************
 VPC
 *****************************************/
resource "ibm_is_vpc" "this" {
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
  vpc  = ibm_is_vpc.this.id
  zone = format("%s-1", var.region) # jp-tok-1
}

resource "ibm_is_subnet" "zone1" {
  depends_on = [
    ibm_is_vpc_address_prefix.zone1
  ]
  ipv4_cidr_block = "10.0.1.0/24"
  name            = format("%s-subnet-zone1", var.vpc_name)

  vpc  = ibm_is_vpc.this.id
  zone = format("%s-1", var.region) # jp-tok-1
}