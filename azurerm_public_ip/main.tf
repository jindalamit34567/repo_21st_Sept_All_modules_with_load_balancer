# This is our sub branch Code 
# I am adding a comment to this file - 4th July--

resource "azurerm_public_ip" "pip" {

name = var.pubilc_ip_name
location = var.location
resource_group_name = var.resource_group_name
allocation_method = var.allocation_method

}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

