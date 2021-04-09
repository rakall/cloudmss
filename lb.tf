resource "azurerm_lb" "elb" {
  name                = "balanceadorFront"
  resource_group_name = var.rg
  location            = var.loc
  sku                 = "Standard"
  load_distribution= "Client IP"
}
resource "azurerm_public_ip" "ippublica" {
  name                = "ippublicabalanceador"
  resource_group_name = var.rg
  location            = var.loc
  allocation_method   = "Static"

  tags = {
    environment = "Production"
  }
}

#load_distribution= [None|Client IP|Client IP and Protocol]
resource "azurerm_lb_probe" "elb_probe" {
  name                = "probe"

  resource_group_name = var.rg
  loadbalancer_id     = azurerm_lb.elb.id
  protocol            = "Tcp"
  port                = "8117"
  interval_in_seconds = "5"
  number_of_probes    = "2"
  depends_on          = [azurerm_lb.elb]
}
