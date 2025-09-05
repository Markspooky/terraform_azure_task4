terraform {
  required_version = ">= 1.6.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.107.0"
    }
  }
}


provider "azurerm" {
  features {}
  subscription_id = "8fe13b09-004b-4e3b-b637-367dea39fb93"
}
