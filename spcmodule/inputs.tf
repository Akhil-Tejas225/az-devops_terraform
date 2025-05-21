variable "azurerm_kubernetes_cluster" {
  description = "aks"
  type = object({
    resource_group_name   = string
    location              = string
    vm_size               = string
    node_count            = number
    random_id_byte_length = number
    dns_label             = string
    aksname               = string
    admin_username        = string

  })
  default = {
    resource_group_name   = "aksrg"
    location              = "centralindia"
    vm_size               = "Standard_B2s"
    node_count            = 1
    random_id_byte_length = 1
    dns_label             = "aks225"
    aksname               = "akhilsaks"
    admin_username        = "akhilgc009"

  }

}