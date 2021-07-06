# Product variables
subscription_id          = "04cfef00-086d-4f47-bb60-e2ed0e6843da"
location                 = "westeurope"
vnet_resource_group_name = "gmsp1zu2rsgcomhubcrit001"
resource_group_nic_name  = "rg-nic"
resource_group_spc_name  = "rg-spc"
resource_group_snc_name  = "rg-snc"
#resourceVnets=rg-vnet   =rg-vnet
zones                    = [1,2]
vnet_name          = ""
snt_front_nic_name = ""
snt_back_nic_name  = ""
snt_front_spc_name = ""
snt_back_spc_name  = ""
snt_front_snc_name = ""
snt_back_snc_name  = ""

cost_center   = "CostCenterTest"
tracking_code = "teckingtest"
environment   = "p1"
entity        = "gms"

managementServer = "cybp1weugengenerintfwmds"
name_sicKeySecret = "chkp-key"
vmss_sku = "Standard_D3_v2"

sa_name_nic = "bootdiag7t3fjjfxqe4hg"
sa_name_spc = "bootdiagzw6jdr4vvy27u"
sa_name_snc = "gmsp1zu2vssgenerintfw003"

lwk_id_nic = ""
lwk_id_spc = ""
lwk_id_snc = ""

key_vault_id_nic = ""
key_vault_id_spc = ""
key_vault_id_snc = ""

nic_ip_prefix_assignment = [
  {
    pip_name    = "ctop1weulbanicfrontfw001-pip01"
    prefix_name = "ctop1weulbanicfrontfw001-ppp01"
  }

]

nic_pip_rule_map_list = [
  {
    pip_name      = "ctop1weulbanicfrontfw001-pip01"
    protocol      = "TCP"
    frontend_port = 443
    backend_port  = 8080
  }

]

nic_template_name = "AZgmshubzu2fwinet30"
spc_template_name = "AZgmshubzu2fwpro30"
snc_template_name = "AZgmshubzu2fwnopro30"
