provider "azurerm" {
  subscription_id = var.subscription_id
  features {}
  version = "=2.0.0"
}

data "azurerm_client_config" "current" {}


resource "azurerm_marketplace_agreement" "checkpoint" {
  publisher = local.publisher
  offer     = local.offer
  plan      = local.sku
}


data "azurerm_resource_group" "rsg_nic" {
  name = var.resource_group_nic_name
  #depends_on = [module.rsg_module_nic]
}

data "azurerm_key_vault" "kvt_nic" {
  name                = local.kvt_name_nic
  resource_group_name = data.azurerm_resource_group.rsg_nic.name
  depends_on          = [data.azurerm_resource_group.rsg_nic]
}

data "azurerm_storage_account" "sta_nic" {
  name                = var.sa_name_nic
  resource_group_name = data.azurerm_resource_group.rsg_nic.name
}

data "azurerm_resource_group" "rsg_spc" {
  name = var.resource_group_spc_name
  #depends_on = [module.rsg_module_spc]
}

data "azurerm_key_vault" "kvt_spc" {
  name                = local.kvt_name_spc
  resource_group_name = data.azurerm_resource_group.rsg_spc.name
  depends_on          = [data.azurerm_resource_group.rsg_spc]
}

data "azurerm_storage_account" "sta_spc" {
  name                = var.sa_name_spc
  resource_group_name = data.azurerm_resource_group.rsg_spc.name
}


data "azurerm_resource_group" "rsg_snc" {
  name = var.resource_group_snc_name
  #depends_on = [module.rsg_module_snc]
}

data "azurerm_key_vault" "kvt_snc" {
  name                = local.kvt_name_snc
  resource_group_name = data.azurerm_resource_group.rsg_snc.name
  depends_on          = [data.azurerm_resource_group.rsg_snc]
}

data "azurerm_storage_account" "sta_snc" {
  name                = var.sa_name_snc
  resource_group_name = data.azurerm_resource_group.rsg_snc.name
}

data "azurerm_log_analytics_workspace" "lag_nic" {
  name                = local.lwk_name_nic
  resource_group_name = data.azurerm_resource_group.rsg_nic.name
}

data "azurerm_log_analytics_workspace" "lag_spc" {
  name                = local.lwk_name_spc
  resource_group_name = data.azurerm_resource_group.rsg_spc.name
}

data "azurerm_log_analytics_workspace" "lag_snc" {
  name                = local.lwk_name_snc
  resource_group_name = data.azurerm_resource_group.rsg_snc.name
}

// Deploy network components for the 3 Firewall clusters
#

data "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.vnet_resource_group_name
}

data "azurerm_subnet" "nicfw_sntdeploy_front" {
  name                 = var.snt_front_nic_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.vnet_resource_group_name
}

data "azurerm_subnet" "nicfw_sntdeploy_back" {
  name                 = var.snt_back_nic_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.vnet_resource_group_name

}
data "azurerm_subnet" "spcfw_sntdeploy_front" {
  name                 = var.snt_front_spc_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.vnet_resource_group_name
}

data "azurerm_subnet" "spcfw_sntdeploy_back" {
  name                 = var.snt_back_spc_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.vnet_resource_group_name
}

data "azurerm_subnet" "sncfw_sntdeploy_front" {
  name                 = var.snt_front_snc_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.vnet_resource_group_name
}

data "azurerm_subnet" "sncfw_sntdeploy_back" {
  name                 = var.snt_back_snc_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.vnet_resource_group_name
}

module "nicfw_nvadeploy" {
  source         = "git::https://github.alm.europe.cloudcenter.corp/ccc-ccoe/eac.az.modules.nva-checkpoint-north.git?ref=v1.0.11"
  resource_group = data.azurerm_resource_group.rsg_nic.name
  product_name   = "NorthInternetCorporate"
  entity         = var.entity
  lwk_id         = var.lwk_id_nic
  snt_front_name = var.snt_front_nic_name
  snt_back_name  = var.snt_back_nic_name
  zones          = var.zones
  vnet_name                = data.azurerm_virtual_network.vnet.name
  vnet_resource_group_name = var.vnet_resource_group_name
  instances                = var.instances
  sa_name                  = data.azurerm_storage_account.sta_nic.name

  key_vault_id      = var.key_vault_id_nic
  name_sicKeySecret = var.name_sicKeySecret

  offer     = local.offer
  ver       = local.ver
  useradmin = local.useradmin

  channel       = local.channel
  description   = local.description
  tracking_code = var.tracking_code
  cia           = local.cia

  # NVA customdata configuration 
  location             = var.location
  managementServer     = var.managementServer
  ip_prefix_assignment = var.nic_ip_prefix_assignment
  pip_rule_map_list    = var.nic_pip_rule_map_list
  subscription_id      = var.subscription_id
  vmss_sku             = var.vmss_sku
  nic_template_name    = var.nic_template_name
}



// Deploy NVA servers South Production Corporate SPC

module "spcfw_nvadeploy" {
  source         = "git::https://github.alm.europe.cloudcenter.corp/ccc-ccoe/eac.az.modules.nva-checkpoint.git?ref=v1.0.9"
  resource_group = data.azurerm_resource_group.rsg_spc.name
  product_name   = "SouthProductionCorporate"
  entity         = var.entity
  lwk_id         = var.lwk_id_spc
  snt_front_name = var.snt_front_spc_name
  snt_back_name  = var.snt_back_spc_name
  zones          = var.zones

  vnet_name                = data.azurerm_virtual_network.vnet.name
  vnet_resource_group_name = var.vnet_resource_group_name

  sa_name           = data.azurerm_storage_account.sta_spc.name
  key_vault_id      = var.key_vault_id_spc
  name_sicKeySecret = var.name_sicKeySecret


  offer         = local.offer
  ver           = local.ver
  useradmin     = local.useradmin
  channel       = local.channel
  description   = local.description
  tracking_code = var.tracking_code
  cia           = local.cia


  # NVA customdata configuration 
  location         = var.location
  managementServer = var.managementServer
  subscription_id  = var.subscription_id
  vmss_sku         = var.vmss_sku
  template_name    = var.spc_template_name
}

// Deploy NVA servers South non-Production Corporate SNC

module "sncfw_nvadeploy" {
  source         = "git::https://github.alm.europe.cloudcenter.corp/ccc-ccoe/eac.az.modules.nva-checkpoint.git?ref=v1.0.9"
  resource_group = data.azurerm_resource_group.rsg_snc.name
  product_name   = "SouthnoProductionCorporate"
  entity         = var.entity
  lwk_id         = var.lwk_id_snc
  snt_front_name = var.snt_front_snc_name
  snt_back_name  = var.snt_back_snc_name

  #vnet info
  vnet_name                = data.azurerm_virtual_network.vnet.name
  vnet_resource_group_name = var.vnet_resource_group_name
  #subnet
  #elb External Network load balancer
  #sa Storage account to store the bootdiags
  #sa_name = "${var.entity}${var.environment}${lookup(var.location_short, var.location)}sta${element(local.product_name_short, 2)}gen${local.product_purpose}004"
  sa_name = data.azurerm_storage_account.sta_snc.name
  # NVA name 
  key_vault_id      = var.key_vault_id_snc
  name_sicKeySecret = var.name_sicKeySecret
  offer             = local.offer
  ver               = local.ver
  zones             = var.zones
  useradmin         = local.useradmin
  channel           = local.channel
  description       = local.description
  tracking_code     = var.tracking_code
  cia               = local.cia
  # NVA customdata configuration 

  location         = var.location
  managementServer = var.managementServer
  subscription_id  = var.subscription_id
  vmss_sku         = var.vmss_sku
  template_name    = var.snc_template_name

}

