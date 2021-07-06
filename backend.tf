terraform {
  backend "azurerm" {
     subscription_id      = "aa746f8d-136f-4bbc-b703-1b2ac5236889"
     resource_group_name  = "tsti2weursgnicgenntfw001"
     storage_account_name = "tsti2weustanicgenntfw004"
     container_name       = "tfstate"
     key                  = "hub-nva-firewall.tfstate"
  }
}
