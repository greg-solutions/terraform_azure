
output "private_subnet_id" {
  value = "${azurerm_subnet.private_subnet.id}"
}

output "public_subnet_id" {
  value = "${azurerm_subnet.public_subnet.id}"
}

output "name" {
  value = "${azurerm_resource_group.application_resource_group.name}"
}

output "location" {
  value = "${azurerm_resource_group.application_resource_group.location}"
}

output "id" {
  value = "${azurerm_resource_group.application_resource_group.id}"
}