resource "azurerm_lb" "elb" {
  name                = "balanceadorFront"
  resource_group_name = var.rg
  location            = var.loc
  sku                 = "Standard"
}

resource "azurerm_lb_probe" "elb_probe" {
  name                = "probe-${local.elb_name}"
  resource_group_name = var.rg
  loadbalancer_id     = azurerm_lb.elb.id
  protocol            = "Tcp"
  port                = "8117"
  interval_in_seconds = "5"
  number_of_probes    = "2"
  depends_on          = [azurerm_lb.elb]
}
