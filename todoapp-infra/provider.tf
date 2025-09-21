# terraform {
#   required_providers {
#     azurerm = {
#         source = "hashicorp/azurerm"
#         version = "4.45.0"
#     }
#   }
# }

provider "azurerm" {
  subscription_id = "6c761c36-4c56-487c-b652-ae74bc150109"
  features {}
}