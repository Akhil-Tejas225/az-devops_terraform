resource "azurerm_resource_group" "RG" {
  name     = var.azurerm_kubernetes_cluster.resource_group_name
  location = var.azurerm_kubernetes_cluster.location
}
resource "random_id" "dns" {
  byte_length = var.azurerm_kubernetes_cluster.random_id_byte_length
}
resource "tls_private_key" "tls_private_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}


resource "azurerm_kubernetes_cluster" "akscluster" {
  name                = var.azurerm_kubernetes_cluster.aksname
  location            = var.azurerm_kubernetes_cluster.location
  resource_group_name = azurerm_resource_group.RG.name
  dns_prefix          = "${var.azurerm_kubernetes_cluster.random_id_byte_length}${var.azurerm_kubernetes_cluster.dns_label}"
  default_node_pool {
    name       = "default"
    vm_size    = var.azurerm_kubernetes_cluster.vm_size
    node_count = var.azurerm_kubernetes_cluster.node_count
  }
  identity {
  type = "SystemAssigned"
}
  linux_profile {
    admin_username = var.azurerm_kubernetes_cluster.admin_username
    ssh_key {
      key_data = tls_private_key.tls_private_key.public_key_openssh
    }

  }

}
resource "null_resource" "getkubecred" {
  provisioner "local-exec" {
    command = <<EOT
    az aks get-credentials --resource-group ${azurerm_resource_group.RG.name} --name ${azurerm_kubernetes_cluster.akscluster.name}
    EOT
  }
}