
output "private_subnet_id" {
  value = "${azurerm_subnet.private_subnet.id}"
}

output "public_subnet_id" {
  value = "${azurerm_subnet.public_subnet.id}"
}

output "resource_group_name" {
  value = "${azurerm_resource_group.application_resource_group.name}"
}

output "resource_group_location" {
  value = "${azurerm_resource_group.application_resource_group.location}"
}

output "resource_group_id" {
  value = "${azurerm_resource_group.application_resource_group.id}"
}