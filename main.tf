provider "azurerm" {
  features {}
}
resource "azurerm_resource_group" "rgterraformtest" {
  name     = "rg-terraform-test"
  location = "West Europe"
}


resource "azurerm_public_ip" "example" {
  name                = "acceptanceTestPublicIp1"
  resource_group_name = azurerm_resource_group.rgterraformtest.name
  location            = azurerm_resource_group.rgterraformtest.location
  allocation_method   = "Static"
  domain_name_label   = "pruebatagdns-name"
  sku                 = "Standard"
  tags = {
    environment = "Test Lab"
  }
}


resource "azurerm_lb" "elb" {
  name                = "ExternalLoadBalancerTest"
  resource_group_name = azurerm_resource_group.rgterraformtest.name
  location            = azurerm_resource_group.rgterraformtest.location
  sku                 = "Standard"
  frontend_ip_configuration {
    name                 = "IPFRONTEND"
    public_ip_address_id = azurerm_public_ip.example.id
  }
}

resource "azurerm_lb_rule" "elb_rule" {
  name                           = "regladeprueba"
  resource_group_name            = azurerm_resource_group.rgterraformtest.name
  loadbalancer_id                = azurerm_lb.elb.id
  frontend_ip_configuration_name = "IPFRONTEND"
  protocol                       = "TCP"
  frontend_port                  = "443"
  backend_port                   = "10001"
  backend_address_pool_id        = azurerm_lb_backend_address_pool.elb_pool.id
  probe_id                       = azurerm_lb_probe.elb_probe.id
  load_distribution              = "Default"
  enable_floating_ip             = true

}

resource "azurerm_lb_backend_address_pool" "elb_pool" {
  resource_group_name = azurerm_resource_group.rgterraformtest.name
  loadbalancer_id     = azurerm_lb.elb.id
  name                = "Backpool-Test"
  depends_on          = [azurerm_lb.elb]
}

resource "azurerm_lb_probe" "elb_probe" {
  name                = "probe-prueba"
  resource_group_name = azurerm_resource_group.rgterraformtest.name
  loadbalancer_id     = azurerm_lb.elb.id
  protocol            = "Tcp"
  port                = "8117"
  interval_in_seconds = "5"
  number_of_probes    = "2"
  depends_on          = [azurerm_lb.elb]
}
