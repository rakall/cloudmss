terraform {
  backend "azurerm" {
    subscription_id      = "04cfef00-086d-4f47-bb60-e2ed0e6843da"
    resource_group_name  = "RG-AzureDevops"
    storage_account_name = "saterraformdevops"
    container_name       = "terraform"
    key                  = "terraform.tfstate"
  }
}
