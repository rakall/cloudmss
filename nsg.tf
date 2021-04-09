provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg-nsg" {
  name = var.rg
  location = var.loc
}

resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-acceso"
  location = var.loc
  resource_group_name = var.rg

   security_rule {
    name                       = "ReglaAcceso"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Labs"
  }
}
