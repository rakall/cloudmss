resource "azurerm_lb" "elb" {
  name                = "balanceadorFront"
  resource_group_name = var.rg
  location            = var.loc
  sku                 = "Standard"
  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.ippublica.id
  }
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


resource "azurerm_lb_rule" "example" {
  #load_distribution= "Client IP"
  resource_group_name = var.rg
  loadbalancer_id                = azurerm_lb.elb.id
  name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 3389
  backend_port                   = 3389
  frontend_ip_configuration_name = "ippublica"
}
