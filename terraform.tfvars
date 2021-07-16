//#PLEASE reffer to the README.md for accepted values FOR THE VARIABELS BELOW
client_secret                   = ""                                     # "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
client_id                       = ""                                         # "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
tenant_id                       = ""                                         # "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
subscription_id                 = ""                                   # "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
source_image_vhd_uri            = "noCustomUri"               # "noCustomUri"
resource_group_name             = "checkpoint-ha-terraform"                               # "checkpoint-ha-terraform"
cluster_name                    = "PLEASE ENTER CLUSTER NAME"                                      # "checkpoint-ha-terraform"
location                        = "westeu"                                          # "eastus"
vnet_name                       = "checkpoint-ha-vnet"                              # "checkpoint-ha-vnet"
address_space                   = "10.0.0.0/16"                     # "10.0.0.0/16"
subnet_prefixes                 = "["10.0.1.0/24","10.0.2.0/24"]                    # ["10.0.1.0/24","10.0.2.0/24"]
admin_password                  = "PPassword1234"                                    # "xxxxxxxxxxxx"
sic_key                         = "Password1234"                                           # "xxxxxxxxxxxx"
vm_size                         = "Standard_D3_v2"                                           # "Standard_D3_v2"
disk_size                       = "110"                                         # "110"
vm_os_sku                       = "sg-byol"                                            # "sg-byol"
vm_os_offer                     = "check-point-cg-r8030"                                          # "check-point-cg-r8030"
os_version                      = "R80.30"                                   # "R80.30"
bootstrap_script                = ""        # "touch /home/admin/bootstrap.txt; echo 'hello_world' > /home/admin/bootstrap.txt"
allow_upload_download           = "PLEASE ENTER true or false"                                     # true
authentication_type             = "Password"                               # "Password"
availability_type               = "Availability Zone"                                 # "Availability Zone"
enable_custom_metrics           = "false"                                     # true
