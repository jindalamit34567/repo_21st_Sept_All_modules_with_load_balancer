data "azurerm_subnet" "my-subnet" {
  name                 = var.frontend_subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.resource_group_name
} 