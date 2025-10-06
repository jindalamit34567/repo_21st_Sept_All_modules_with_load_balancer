

resource "azurerm_bastion_host" "mybastion" {
  name                = "examplebastion"
  location            = var.location
  resource_group_name = var.resource_group_name

 
  ip_configuration {
    name                 = "configuration"
    subnet_id            = data.azurerm_subnet.ajindal-subnet.id
    public_ip_address_id = data.azurerm_public_ip.pip.id

  }

}

data "azurerm_subnet" "ajindal-subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.resource_group_name
}

data "azurerm_public_ip" "pip" {
  name                = var.public_ip_name
  resource_group_name = var.resource_group_name
}

