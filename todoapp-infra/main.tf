module "public_ip_lb" {
  source              = "..//azurerm_public_ip"
  pubilc_ip_name      = "myPublicIP"
  location            = "central india"
  resource_group_name = "ajindal-rg"
  allocation_method   = "Static"
  sku                 = "Standard"
}


module "public_ip_bastion" {
  source              = "..//azurerm_public_ip"
  pubilc_ip_name      = "bastion_ip"
  location            = "central india"
  resource_group_name = "ajindal-rg"
  allocation_method   = "Static"
  sku                 = "Standard"
}
module "virtual_network" {

  source = "..//azurerm_virtual_network"

  virtual_network_name     = "my-network"
  virtual_network_location = "central india"
  resource_group_name      = "ajindal-rg"
  address_space            = ["10.0.0.0/16"]
}


module "bastion_subnet" {
  depends_on = [module.virtual_network]
  source     = "../azurerm_subnet"

  subnet_name          = "azurebastionsubnet"
  resource_group_name  = "ajindal-rg"
  virtual_network_name = "vnet-lb"
  address_prefixes     = ["10.0.3.0/24"]
}

module "bastion" {
  depends_on = [ module.bastion_subnet, module.public_ip_bastion]
  source = "../azurerm_bastion"
  subnet_name = "azurebastionsubnet"
  vnet_name = "vnet-lb"
  rg_name = "ajindal-rg"
  pip_name = "bastion_ip"
  bastion_name = "my-bastion"
  location = "central india"
  resource_group_name = "ajindal-rg"


}
module "frontend_subnet" {
  depends_on = [module.virtual_network]
  source     = "../azurerm_subnet"

  subnet_name          = "my-subnet"
  resource_group_name  = "ajindal-rg"
  virtual_network_name = "my-network"
  address_prefixes     = ["10.0.2.0/24"]
}



module "chinki_vm" {
  depends_on = [module.virtual_network, module.frontend_subnet]
  source     = "../azurerm_virtual_machine"

  resource_group_name  = "ajindal-rg"
  location             = "central india"
  vm_name              = "chinki-vm"
  vm_size              = "Standard_DS1_v2"
  admin_username       = "devopsadmin"
  admin_password       = "Redhat@12345"
  image_publisher      = "Canonical"
  image_offer          = "0001-com-ubuntu-server-jammy"
  image_sku            = "22_04-lts"
  image_version        = "latest"
  nic_name             = "my-nic"
  vnet_name            = "my-network"
  frontend_subnet_name = "my-subnet"
  nsg_name = "chinki-nsg"


}

module "pinki_vm" {
  depends_on = [module.virtual_network, module.frontend_subnet]
  source     = "../azurerm_virtual_machine"

  resource_group_name  = "ajindal-rg"
  location             = "central india"
  vm_name              = "pinki-vm"
  vm_size              = "Standard_DS1_v2"
  admin_username       = "devopsadmin"
  admin_password       = "Redhat@12345"
  image_publisher      = "Canonical"
  image_offer          = "0001-com-ubuntu-server-jammy"
  image_sku            = "22_04-lts"
  image_version        = "latest"
  nic_name             = "my-nic"
  vnet_name            = "my-network"
  frontend_subnet_name = "my-subnet"
  nsg_name = "pinki-nsg"

}



module "lb" {
  depends_on = [module.public_ip_lb]
  source     = "..//azurerm_load_balancer"


}

module "nic_lb_association_chinki" {
  depends_on = [module.chinki_vm, module.lb]
  source     = "../azurerm_nic_lb_association"
  nic_name               = "my-nic"
  lb_name                = "my-LoadBalancer"
  bap_name               = "lb-BackEndAddressPool"
  ip_configuration_name  = "testconfiguration1"
}

module "nic_lb_association_pinki" {
  depends_on = [module.pinki_vm, module.lb]
  source     = "../azurerm_nic_lb_association"
  nic_name               = "my-nic"
  lb_name                = "my-LoadBalancer"
  bap_name               = "lb-BackEndAddressPool"
  ip_configuration_name  = "testconfiguration1"
}