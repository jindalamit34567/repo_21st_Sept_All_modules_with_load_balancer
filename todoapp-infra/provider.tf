terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.45.0"
    }
  }
}

provider "azurerm" {
  features{}
  subscription_id = "fc9a9c60-f70d-43e1-85cc-80d8a3a522c8"

}