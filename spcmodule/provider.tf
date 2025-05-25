terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.29.0"
    }
  }
}
backend "azurerm" {
      resource_group_name  = "k8s"
      storage_account_name = "k8ssa225"
      container_name       = "container225"
      key                  = "terraform.tfstate"
  }
provider "azurerm" {
  features {}
  subscription_id = "47de7ab7-a7a8-4cb3-8dfc-fc320a284146"


}