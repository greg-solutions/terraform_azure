resource "azurerm_resource_group" "application_resource_group" {
  name = "${var.app_name}-resources"
  location = "${var.location}"
}

resource "azurerm_route_table" "application_route_table" {
  name = "${var.app_name}-application-route-table"
  location = "${azurerm_resource_group.application_resource_group.location}"
  resource_group_name = "${azurerm_resource_group.application_resource_group.name}"

  route {
    name = "default"
    address_prefix = "${var.cidr}"
    next_hop_type = "${var.next_hop_type}"
    next_hop_in_ip_address = "${var.next_hop_in_ip_address}"
  }
}

resource "azurerm_virtual_network" "public_network" {
  name = "${var.app_name}-public-network"
  location = "${azurerm_resource_group.application_resource_group.location}"
  resource_group_name = "${azurerm_resource_group.application_resource_group.name}"
  address_space = ["${cidrsubnet(azurerm_route_table.application_route_table.subnets, 8, count.index)}"]

}

resource "azurerm_virtual_network" "private_network" {
  name = "${var.app_name}-private-network"
  location = "${azurerm_resource_group.application_resource_group.location}"
  resource_group_name = "${azurerm_resource_group.application_resource_group.name}"
  address_space = ["${cidrsubnet(azurerm_route_table.application_route_table.subnets, 8, count.index)}"]
}

/*
  A subnet is a range of IP addresses in resource group, where resources can be securely launched. Public subnet is used for
  resources that must be connected to the Internet.
*/
resource "azurerm_subnet" "public_subnet" {
  name = "${var.app_name}-public-subnet"
  resource_group_name = "${azurerm_resource_group.application_resource_group.name}"
  address_prefix = "${cidrsubnet(azurerm_route_table.application_route_table.subnets, 8, count.index)}"
  virtual_network_name = "${azurerm_virtual_network.public_network.name}"
}

/*
  A subnet is a range of IP addresses in resource group, where resources can be securely launched. Private subnet is uded for
  resources that won't be connected to the Internet.
*/
resource "azurerm_subnet" "private_subnet" {
  name = "${var.app_name}-private-subnet"
  resource_group_name = "${azurerm_resource_group.application_resource_group.name}"
  address_prefix = "${cidrsubnet(azurerm_route_table.application_route_table.subnets, 8, count.index)}"
  virtual_network_name = "${azurerm_virtual_network.private_network.name}"
}