terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.46.0"
    }
  }
}

provider "azurerm" {
    features {}
    subscription_id = "cefa80e5-9af0-4e4a-9f43-e0a0491a5473"
    # tenant_id       = "ba464e9e-9154-4fc0-9582-760e55463849"
    # client_id       = "1aa4636c-a37f-43b6-b02d-53152d0f91b4"
    # client_secret   = "Tmn8Q~FCtBMhiDp0qNq9eYvRCsPcmnfLDo5oxaSK"
}