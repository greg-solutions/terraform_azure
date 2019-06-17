resource "azurerm_resource_group" "application_resource_group" {
  name = "${lower(format("%s-resources",var.app_name))}"
  location = "${var.location}"
}

resource "azurerm_route_table" "application_route_table" {
  name = "${lower(format("%s-application-route-table",var.app_name))}"
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
  name = "${lower(format("%s-public-network",var.app_name))}"
  location = "${azurerm_resource_group.application_resource_group.location}"
  resource_group_name = "${azurerm_resource_group.application_resource_group.name}"
  address_space = [
    "${cidrsubnet(var.cidr, 8, 1)}"]

}

resource "azurerm_virtual_network" "private_network" {
  name = "${lower(format("%s-private-network",var.app_name))}"
  location = "${azurerm_resource_group.application_resource_group.location}"
  resource_group_name = "${azurerm_resource_group.application_resource_group.name}"
  address_space = [
    "${cidrsubnet(var.cidr, 8, 2)}"]
}

/*
  A subnet is a range of IP addresses in resource group, where resources can be securely launched. Public subnet is used for
  resources that must be connected to the Internet.
*/
resource "azurerm_subnet" "public_subnet" {
  name = "${lower(format("%s-public-subnet",var.app_name))}"
  resource_group_name = "${azurerm_resource_group.application_resource_group.name}"
  address_prefix = "${cidrsubnet(var.cidr, 8, 1)}"
  virtual_network_name = "${azurerm_virtual_network.public_network.name}"
}

/*
  A subnet is a range of IP addresses in resource group, where resources can be securely launched. Private subnet is uded for
  resources that won't be connected to the Internet.
*/
resource "azurerm_subnet" "private_subnet" {
  name = "${lower(format("%s-private-subnet",var.app_name))}"
  resource_group_name = "${azurerm_resource_group.application_resource_group.name}"
  address_prefix = "${cidrsubnet(var.cidr, 8, 2)}"
  virtual_network_name = "${azurerm_virtual_network.private_network.name}"
}


resource "azurerm_network_security_group" "public_nsg" {
  name = "${lower(format("%s-security-group",var.app_name))}"
  resource_group_name = "${azurerm_resource_group.application_resource_group.name}"
  location = "${azurerm_resource_group.application_resource_group.location}"
}

resource "azurerm_network_security_group" "private_nsg" {
  name = "${lower(format("%s-private-nsg",var.app_name))}"
  resource_group_name = "${azurerm_resource_group.application_resource_group.name}"
  location = "${azurerm_resource_group.application_resource_group.location}"
}

# NOTE: this allows SSH from any network
resource "azurerm_network_security_rule" "public_nsr_ssh" {
  name = "${lower(format("%s-private-nsg",var.app_name))}"
  resource_group_name = "${azurerm_resource_group.application_resource_group.name}"
  network_security_group_name = "${azurerm_network_security_group.public_nsg.name}"
  priority = 102
  direction = "Inbound"
  access = "Allow"
  protocol = "Tcp"
  source_port_range = "*"
  destination_port_range = "22"
  source_address_prefix = "*"
  destination_address_prefix = "*"
}