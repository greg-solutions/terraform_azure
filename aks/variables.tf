variable "app_name" {
  description = "Name of application to make provisioning for. Almost all resources, created within resource group will be tagged with this value"
  default = "Test-App"
}
/*The Azure Region in which the managed Kubernetes Cluster exists.*/
variable "location" {
  default = ""
}

/* Network plugin used such as azure or kubenet.*/
variable "kubernetes_network_plugin" {
  default = "azure"
}

/*The DNS Prefix of the managed Kubernetes cluster.*/
variable "kubernetes_dns_prefix" {
  default = "test"
}

variable "kubernetes_client_id" {
  description = "The Client ID for the Service Principal to use for this Managed Kubernetes Cluster"
}

variable "kubernetes_client_secret" {
  description = "The Client Secret for the Service Principal to use for this Managed Kubernetes Cluster"
}

/*The number of Agents (VM's) in the Pool.*/
variable "kubernetes_agent_count" {
  default = "2"
}

/*The size of each VM in the Agent Pool (e.g. Standard_F1).*/
variable "kubernetes_vm_size" {
  default = "Standard_DS2_v2"
}

variable "kubernetes_os_disk_size_gb" {
  default = "30"
}

/*The Operating System used for the Agents.*/
variable "kubernetes_os_type" {
  default = "Linux"
}

/*
The version of Kubernetes used on the managed Kubernetes Cluster.
https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG.md
*/
variable "kubernetes_version" {
  default = "1.12.8"
}

/*The username associated with the administrator account of the managed Kubernetes Cluster.*/
variable "kubernetes_admin_username" {
  default = "acctestuser"
}

/* The Public SSH Key used to access the cluster.*/
variable "public_ssh_key_path" {
  description = "The Path at which your Public SSH Key is located. Defaults to ~/.ssh/id_rsa.pub"
  default = "~/.ssh/id_rsa.pub"
}