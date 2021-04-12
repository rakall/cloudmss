provider "azurerm" {
  features {}
}
resource "azurerm_resource_group" "rgterraf" {
  name     = var.rg
  location = "West Europe"
}
resource "azurerm_public_ip_prefix" "public_ip_prefix" {
  name                = "ppp01"
  location            = var.loc
  resource_group_name = "terraform"
  prefix_length       = 28
}
resource "azurerm_lb" "elb" {
  name                = "Balanceador"
  resource_group_name = var.rg
  location            = var.loc
  sku                 = "Standard"
}
resource "azurerm_lb_probe" "elb_probe" {
  name                = "prob"
  resource_group_name = "terraform"
  loadbalancer_id     = azurerm_lb.elb.id
  protocol            = "Tcp"
  port                = "8117"
  interval_in_seconds = "5"
  number_of_probes    = "2"
  depends_on          = [azurerm_lb.elb]
}
resource "azurerm_lb_rule" "example" {
  resource_group_name = "terraform"
  loadbalancer_id                = azurerm_lb.elb.id
  load_distribution              = "Default"
  name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 3389
  backend_port                   = 3389
  frontend_ip_configuration_name = "PublicIPAddress"
}









