module "azurerm_resource_group" {
  source                   = "../Modules/azurerm_resource_group"
  resource_group_name      = "ajindal-rg3"
  resource_group_location  = "west us"
  
}

module "azurerm_public_ip" {
  source                   = "../Modules/azurerm_public_ip"
  depends_on               = [ module.azurerm_resource_group ]
  public_ip_name           = "mypublic-ip"
  resource_group_name      = "ajindal-rg3"
  location                 = "west us"
  allocation_method        = "Static"
}

module "azurerm_virtual_network" {
  source                   = "../Modules/azurerm_virtual_network"
  depends_on = [ module.azurerm_resource_group ]
  virtual_network_name = "ajindal-vnet"
  address_space            = ["10.0.0.0/16"]
  location                 = "west us"
  resource_group_name = "ajindal-rg3" 
}

module "azurerm_subnet" {
  source                   = "../Modules/azurerm_subnet"
  depends_on = [ module.azurerm_virtual_network]
  subnet_name              = "ajindal-subnet"
  resource_group_name = "ajindal-rg3"
  virtual_network_name = "ajindal-vnet"
  address_prefixes         = ["10.0.1.0/24"]
}

module "azurerm_subnet1" {
  source                   = "../Modules/azurerm_subnet"
  depends_on = [ module.azurerm_virtual_network]
  subnet_name              = "AzureBastionSubnet"
  resource_group_name = "ajindal-rg3"
  virtual_network_name = "ajindal-vnet"
  address_prefixes         = ["10.0.4.0/24"]
}



module "chinki_vm" {
  source                   = "../Modules/azurerm_virtual_machine"
  depends_on               = [ module.azurerm_subnet, module.azurerm_virtual_network ]
  vm_name                  = "chinki-vm"
  resource_group_name      = "ajindal-rg3"
  location                 = "west us"
  nsg_name                 = "chinki-nsg"
  ip_name                  = "ajindal-ip"
  publisher                = "Canonical"
  offer                    = "UbuntuServer"
  sku                      = "18.04-LTS"
  image_version            = "latest"
  nic_name                 = "chinki-nic"
  subnet_name              = "ajindal-subnet"
  virtual_network_name     = "ajindal-vnet"
  admin_username           = "devopsadmin"
  admin_password           = "Redhat@12345"
}


module "pinki_vm" {
  source                   = "../Modules/azurerm_virtual_machine"
  depends_on               = [ module.azurerm_subnet, module.azurerm_virtual_network ]
  vm_name                  = "pinki-vm"
  resource_group_name      = "ajindal-rg3"
  location                 = "west us"
  nsg_name                 = "chinki-nsg"
  ip_name                  = "ajindal-ip"
  publisher                = "Canonical"
  offer                    = "UbuntuServer"
  sku                      = "18.04-LTS"
  image_version            = "latest" 
  nic_name                 = "pinki-nic"
  subnet_name              = "ajindal-subnet"
  virtual_network_name     = "ajindal-vnet"
  admin_username           = "devopsadmin"
  admin_password           = "Redhat@12345"  
  
}

module "lb" {
  source                   = "../Modules/azurerm_load_balancer"
  depends_on               = [ module.azurerm_public_ip, module.azurerm_resource_group, module.azurerm_subnet ]
  location                 = "west us"
  resource_group_name      = "ajindal-rg3"
  lb_name                  = "ajindal-lb"
  public_ip_name           = "mypublic-ip"
  frontend_ip_name         = "ajindal-frontend-ip"
  probe_name               = "ajindal-probe"
  my_backend_pool         = "ajindal-backend-pool"
  lb_rule =                  "ajindal-rule"
}


module "nic_lb_association_chinki" {
  source                   = "../Modules/azurerm_nic_lb_association"
  depends_on               = [ module.lb, module.chinki_vm ]
  nic_name                 = "chinki-nic"
  resource_group_name      = "ajindal-rg3"
  ip_configuration_name    = "ajindal-ip"
  lb_backend_pool        = "ajindal-backend-pool"
  lb_name                  = "ajindal-lb"
  
}

module "nic_lb_association_pinki" {
  source                   = "../Modules/azurerm_nic_lb_association"
  depends_on               = [ module.lb, module.pinki_vm ]
  nic_name                 = "pinki-nic"
  resource_group_name      = "ajindal-rg3"
  ip_configuration_name    = "ajindal-ip"
  lb_backend_pool        = "ajindal-backend-pool"
  lb_name                  = "ajindal-lb"

}

module "azurerm_public_ip1" {
  source                   = "../Modules/azurerm_public_ip"
  depends_on               = [ module.azurerm_resource_group ]
  public_ip_name           = "mypublic-ip-bastion"
  resource_group_name      = "ajindal-rg3"
  location                 = "west us"
  allocation_method        = "Static"
}
module "azurerm_bastion_host" {
  source                   = "../Modules/azurerm_bastion"
  depends_on               = [ module.azurerm_public_ip1, module.azurerm_resource_group, module.azurerm_subnet1 ]
  location                 = "west us"
  resource_group_name      = "ajindal-rg3"
  subnet_name              = "AzureBastionSubnet"
  virtual_network_name     = "ajindal-vnet"
  public_ip_name           = "mypublic-ip-bastion"
}
