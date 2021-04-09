resource "azurerm_lb" "elb" {
  name                = "balanceadorFront"
  resource_group_name = var.resource_group
  location            = var.location
  sku                 = "Standard"
  dynamic "frontend_ip_configuration" {

    for_each = [for pip_name in module.pips.pip_names : {
      name                 = pip_name
      public_ip_address_id = module.pips.pip_ids[index(module.pips.pip_names, pip_name)]

    }]
    content {
      name                 = frontend_ip_configuration.value["name"]
      public_ip_address_id = frontend_ip_configuration.value["public_ip_address_id"]

    }
  }
  tags = {
    channel       = var.channel
    cia           = var.cia
    cost_center   = data.azurerm_resource_group.rsg.tags["cost_center"]
    product       = data.azurerm_resource_group.rsg.tags["product"]
    description   = var.description
    tracking_code = var.tracking_code
  }
  depends_on = [data.azurerm_public_ip.module-pips]
}

resource "azurerm_lb_probe" "elb_probe" {
  name                = "probe-${local.elb_name}"
  resource_group_name = var.resource_group
  loadbalancer_id     = azurerm_lb.elb.id
  protocol            = "Tcp"
  port                = "8117"
  interval_in_seconds = "5"
  number_of_probes    = "2"
  depends_on          = [azurerm_lb.elb]
}

resource "azurerm_lb_rule" "elb_rule" {
  for_each = {
    for rule in var.pip_rule_map_list : "${rule.pip_name}.${rule.frontend_port}" => rule
  }
  name                           = "${each.value.pip_name}-${each.value.frontend_port}-${each.value.backend_port}"
  resource_group_name            = var.resource_group
  loadbalancer_id                = azurerm_lb.elb.id
  frontend_ip_configuration_name = each.value.pip_name
  protocol                       = each.value.protocol
  frontend_port                  = each.value.frontend_port
  backend_port                   = each.value.backend_port
  backend_address_pool_id        = azurerm_lb_backend_address_pool.elb_pool.id
  probe_id                       = azurerm_lb_probe.elb_probe.id
  load_distribution              = "Default"
  enable_floating_ip             = true
  depends_on                     = [azurerm_lb_probe.elb_probe, azurerm_lb_backend_address_pool.elb_pool, azurerm_lb.elb]
}

resource "azurerm_lb_backend_address_pool" "elb_pool" {
  resource_group_name = var.resource_group
  loadbalancer_id     = azurerm_lb.elb.id
  name                = "Backpool-${local.elb_name}"
  depends_on          = [azurerm_lb.elb]
}

resource "azurerm_monitor_diagnostic_setting" "elb_dgm" {
  name                       = "${local.elb_name}-dgm"
  target_resource_id         = azurerm_lb.elb.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.lag.id

  log {
    category = "LoadBalancerAlertEvent"
    enabled  = true

    retention_policy {
      enabled = true
      days    = "30"
    }
  }

  log {
    category = "LoadBalancerProbeHealthStatus"
    enabled  = true

    retention_policy {
      enabled = true
      days    = "30"
    }
  }

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = true
      days    = "30"
    }
  }
  depends_on = [azurerm_lb.elb]
}
