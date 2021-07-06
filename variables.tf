locals {
  product_name_short  = ["nic", "spc", "snc"]
  publisher           = "checkpoint"
  sku                 = "sg-byol"
  nvasize             = "Standard_D3_v2"
  nvaminnodes         = "2"
  nvamaxnodes         = "10"
  installationType    = "vmss"
  allowUploadDownload = "true"
  useradmin           = "notused"
  isBlink             = "true"
  bootstrapScript64   = ""
  product_purpose     = "ntfw"
  offer               = "check-point-cg-r8030"
  ver                 = "latest"
  channel             = "internet"
  description         = "HUB NVA"
  product             = "HubNVA"
  cia                 = "AHC"
  lwk_name_nic        = replace("${var.resource_group_nic_name}", "rsg", "lwk")
  lwk_name_spc        = replace("${var.resource_group_spc_name}", "rsg", "lwk")
  lwk_name_snc        = replace("${var.resource_group_snc_name}", "rsg", "lwk")
  kvt_name_nic        = replace("${var.resource_group_nic_name}", "rsg", "akv")
  kvt_name_spc        = replace("${var.resource_group_spc_name}", "rsg", "akv")
  kvt_name_snc        = replace("${var.resource_group_snc_name}", "rsg", "akv")
  #sa_name_nic  = replace("${var.resource_group_nic_name}", "rsg", "sta")
  #sa_name_spc  = replace("${var.resource_group_spc_name}", "rsg", "sta")
  #sa_name_snc  = replace("${var.resource_group_snc_name}", "rsg", "sta")
}

variable "resource_group_nic_name" {
  type        = string
  description = "Resource Group to deploy NIC NVA"
}
variable "resource_group_spc_name" {
  type        = string
  description = "Resource Group to deploy SPC NVA"
}
variable "resource_group_snc_name" {
  type        = string
  description = "Resource Group to deploy SNC NVA"
}

variable "lwk_id_spc" {
  type = string
  description = "The id of the SPC lwk"
}

variable "lwk_id_snc" {
  type = string
  description = "The id of the SPC lwk"
}

variable "lwk_id_nic" {
  type = string
  description = "The id of the NIC lwk"
}

variable "key_vault_id_spc" {
  type = string
  description = "The id of the SPC kvt"
}

variable "key_vault_id_snc" {
  type = string
  description = "The id of the SNC kvt"
}

variable "key_vault_id_nic" {
  type = string
  description = "The id of the NIC kvt"
}

variable "snt_front_nic_name" {}
variable "snt_back_nic_name" {}
variable "snt_front_snc_name" {}
variable "snt_back_snc_name" {}
variable "snt_front_spc_name" {}
variable "snt_back_spc_name" {}

variable "vnet_resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group where the vnet exists."
}

variable "location" {
  type        = string
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable "vnet_name" {
  type        = string
  description = "(Required) The name of the virtual network."
}

variable "environment" {
  default     = "p1"
  type        = string
  description = "(Optional) the environment"
}

# Subnets information



# TAGS and Naming


variable "tracking_code" {
  type        = string
  description = "(Required) Allow this resource to be matched against internal inventory systems."
}

variable "cost_center" {
  type        = string
  description = "(Mandatory) Specifies the cost_center of the Azure Data Factory."
}

variable "entity" {
  type        = string
  description = "(Required) Entity"
}

variable "location_short" {
  type        = map
  description = "(Optional) Maps the location acronym with the location name."

  default = {
    brazilsouth = "zb1"
    eastus      = "zu1"
    eastus2     = "zu2"
    global      = "glb"
    northeurope = "neu"
    westeurope  = "weu"
    southuk     = "suk"
  }
}


# Variables for the creation of the NVA Virtual MAchine Scale Set


variable "instances" {
  default = 2
}
variable "sa_name_nic" {}
variable "sa_name_spc" {}
variable "sa_name_snc" {}


# Customdata configuration variables (CheckPoint configuration script)

variable "name_sicKeySecret" {
  type        = string
  description = "(Required) Name of the Secret that stores the sicKey"
}


variable "managementServer" {
  type        = string
  description = "(Required) The name of the Management Server"
}

variable "subscription_id" {
  type        = string
  description = "(Required) The Subscription ID"
}
# Public IP
variable "nic_ip_prefix_assignment" {
  type = list(object({
    pip_name    = string,
    prefix_name = string
    })
  )
}

# IP publication list map

variable "nic_pip_rule_map_list" {
  type = list(object({
    pip_name      = string
    protocol      = string
    frontend_port = number
    backend_port  = number

    })
  )
  description = "List of a map that matches each pip_name with its lba rules (pip_name, protocol, frontend_port, backend_port). A PIP name can have multiple lba rules associated defining different frontend ports."
}

variable "vmss_sku" {
  type        = string
  description = "(Required) SKU"
}

variable "nic_template_name" {
  type        = string
  description = "(Required) NIC template name"
}

variable "spc_template_name" {
  type        = string
  description = "(Required) SPC template name"
}

variable "snc_template_name" {
  type        = string
  description = "(Required) SNC template name"
}
variable "zones" {
  type        = list(number)
  description = "(Optional) A list of Availability Zones in which the Virtual Machines in this Scale Set should be created in. Eg. [1, 2, 3]"
  default     = []
}
