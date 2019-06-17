module "azure_resource_group" {
  source = "github.com/greg-solutions/terraform_azure/resource_group"
  app_name = "${var.app_name}"
}

resource "azurerm_kubernetes_cluster" "kubernetes_cluster" {
  name = "kubernetes-cluster"

  location = "${module.azure_resource_group.location}"
  dns_prefix = "${var.kubernetes_dns_prefix}"
  resource_group_name = "${module.azure_resource_group.name}"
  kubernetes_version = "${var.kubernetes_version}"

  linux_profile {
    admin_username = "${var.kubernetes_admin_username}"

    ssh_key {
      key_data = "${file(var.public_ssh_key_path)}"
    }
  }

  agent_pool_profile {
    name = "kubepool"
    count = "${var.kubernetes_agent_count}"
    vm_size = "${var.kubernetes_vm_size}"
    os_type = "${var.kubernetes_os_type}"
    os_disk_size_gb = "${var.kubernetes_os_disk_size_gb}"

    # Required for advanced networking
    vnet_subnet_id = "${module.azure_resource_group.private_subnet_id}"
  }

  service_principal {
    client_id = "${var.kubernetes_client_id}"
    client_secret = "${var.kubernetes_client_secret}"
  }

  network_profile {
    network_plugin = "${var.kubernetes_network_plugin}"
  }
}