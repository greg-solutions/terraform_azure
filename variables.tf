variable "app_name" {
  description = "Name of application to make provisioning for. Almost all resources, created within resource group will be tagged with this value"
  default = "Test-App"
}

/*
Allowed regions: https://azure.microsoft.com/en-us/global-infrastructure/locations/
*/
variable "location" {
  description = "The Azure Region in which all resources in this example should be provisioned"
  default = "West US"
}

/*
The destination CIDR to which the route applies, such as 10.10.0.0/16
*/
variable "cidr" {
  default = "10.10.0.0/16"
}

/*
Contains the IP address packets should be forwarded to. Next hop values are only allowed in routes where the next hop type is VirtualAppliance
*/
variable "next_hop_in_ip_address" {
  default = "10.10.1.1"
}

/*
The type of Azure hop the packet should be sent to. Possible values are VirtualNetworkGateway, VnetLocal, Internet, VirtualAppliance and None.
*/
variable "next_hop_type" {
  default = "VirtualAppliance"
}

variable "public_ssh_key_path" {
  description = "The Path at which your Public SSH Key is located. Defaults to ~/.ssh/id_rsa.pub"
  default = "~/.ssh/id_rsa.pub"
}