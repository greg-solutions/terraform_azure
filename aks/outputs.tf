output "subnet_id_list" {
  value = "${azurerm_kubernetes_cluster.kubernetes_cluster.agent_pool_profile.*.vnet_subnet_id}"
}

output "network_plugin_list" {
  value = "${azurerm_kubernetes_cluster.kubernetes_cluster.network_profile.*.network_plugin}"
}

output "service_cidr_list" {
  value = "${azurerm_kubernetes_cluster.kubernetes_cluster.network_profile.*.service_cidr}"
}

output "dns_service_ip_list" {
  value = "${azurerm_kubernetes_cluster.kubernetes_cluster.network_profile.*.dns_service_ip}"
}

output "docker_bridge_cidr_list" {
  value = "${azurerm_kubernetes_cluster.kubernetes_cluster.network_profile.*.docker_bridge_cidr}"
}

output "pod_cidr_list" {
  value = "${azurerm_kubernetes_cluster.kubernetes_cluster.network_profile.*.pod_cidr}"
}