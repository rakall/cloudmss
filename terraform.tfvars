# Product variables
subscription_id          = "04cfef00-086d-4f47-bb60-e2ed0e6843da"
location                 = "westeurope"
vnet_resource_group_name = "rg-vnet"
resource_group_nic_name  = "rg-nic"
resource_group_spc_name  = "rg-spc"
resource_group_snc_name  = "rg-snc"
#resourceVnets=rg-vnet   =rg-vnet
zones                    = [1,2]
vnet_name          = "vnet-scaleset"
snt_front_nic_name = "snt_front_nic_name"
snt_back_nic_name  = "snt_back_nic_name"
snt_front_spc_name = "snt_front_spc_name"
snt_back_spc_name  = "snt_back_spc_name"
snt_front_snc_name = "snt_front_snc_name"
snt_back_snc_name  = "snt_back_snc_name"

cost_center   = "CostCenterTest"
tracking_code = "teckingtest"
environment   = "p1"
entity        = "test"

managementServer = "cybp1weugengenerintfwmds"
name_sicKeySecret = "chkp-key"
vmss_sku = "Standard_D3_v2"

sa_name_nic = "stanic"
sa_name_spc = "staspc"
sa_name_snc = "stasnc"

lwk_id_nic = "lwknic"
lwk_id_spc = "lwkspc"
lwk_id_snc = "lwksnc"

key_vault_id_nic = "/subscriptions/04cfef00-086d-4f47-bb60-e2ed0e6843da/resourceGroups/rg-nic/providers/Microsoft.KeyVault/vaults/kvidnic"
key_vault_id_spc = "/subscriptions/04cfef00-086d-4f47-bb60-e2ed0e6843da/resourceGroups/rg-spc/providers/Microsoft.KeyVault/vaults/kvidspc"
key_vault_id_snc = "/subscriptions/04cfef00-086d-4f47-bb60-e2ed0e6843da/resourceGroups/rg-snc/providers/Microsoft.KeyVault/vaults/kvidsnc"

nic_ip_prefix_assignment = [
  {
    pip_name    = "test-pip01"
    prefix_name = "testscaleset-ppp01"
  }

]

nic_pip_rule_map_list = [
  {
    pip_name      = "testscaleset-pip01"
    protocol      = "TCP"
    frontend_port = 443
    backend_port  = 8080
  }

]

nic_template_name = "AZtestinet30"
spc_template_name = "AZtestpro30"
snc_template_name = "AZtestnopro30"
