terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.13.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "tf_test" {
  name = "tfrg"
  location = "east us"
}

resource "azurerm_container_group" "tfci_test" {
  name                = "container-group"
  location            = azurerm_resource_group.tf_test.location
  resource_group_name = azurerm_resource_group.tf_test.name
  ip_address_type     = "Public"
  dns_name_label      = "weatherapi"
  os_type             = "Linux"

  container {
    name   = "weatherapi"
    image  = "balop3e/waetherapi"
    cpu    = "1"
    memory = "1.5"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }
}