resource "azurerm_virtual_network" "my-vnet" {
  name                = "my-network"
  location            = "central india"
  resource_group_name = "ajindal-rg"
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name             = "subnet1"
    address_prefixes = ["10.0.1.0/24"]
  }
}