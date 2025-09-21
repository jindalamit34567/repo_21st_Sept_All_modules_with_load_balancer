module "virtual_network" {

    source = "../Modules/azurerm_virtual_network"

    virtual_network_name                = "my-network"
    virtual_network_location            = "central india"
    resource_group_name                 =  "ajindal-rg"
    address_space                       = ["10.0.0.0/16"]
}


module "frontend_subnet" {
    depends_on = [module.virtual_network]
    source = "../Modules/azurerm_subnet"

    subnet_name          = "my-subnet"
    resource_group_name  = "ajindal-rg"
    virtual_network_name = "my-network"
    address_prefixes     = ["10.0.1.0/24"]
}



module "chinki_vm" {
  depends_on = [ module.virtual_network, module.frontend_subnet ]
  source = "../Modules/azurerm_virtual_machine"
  
  resource_group_name   = "ajindal-rg"
  location              = "central india"   
  vm_name                  = "chinki-vm"
  vm_size               = "Standard_DS1_v2"
  admin_username        = "devopsadmin"
  admin_password        = "Redhat@12345"
  image_publisher     = "Canonical"
  image_offer         = "0001-com-ubuntu-server-jammy"
  image_sku           = "22_04-lts"
  image_version       = "latest"    
  nic_name             = "my-nic"
  vnet_name         = "my-network"
  frontend_subnet_name = "my-subnet"
  

}

module "pinki_vm" {
  depends_on = [ module.virtual_network, module.frontend_subnet ]
  source = "../Modules/azurerm_virtual_machine"
  
  resource_group_name   = "ajindal-rg"
  location              = "central india"   
  vm_name                  = "pinki-vm"
  vm_size               = "Standard_DS1_v2"
  admin_username        = "devopsadmin"
  admin_password        = "Redhat@12345"
  image_publisher     = "Canonical"
  image_offer         = "0001-com-ubuntu-server-jammy"
  image_sku           = "22_04-lts"
  image_version       = "latest"    
  nic_name             = "my-nic"
  vnet_name         = "my-network"
  frontend_subnet_name = "my-subnet"

}

# module "public_ip_lb" {
#     source = "../Modules/azurerm_public_ip"
#     pubilc_ip_name = "myPublicIP"
#     location = "central india"
#     resource_group_name = "rg-todoapp"
#     allocation_method = "Static"
# }

# module "lb" {
#   depends_on = [ module.public_ip_lb ]  
#   source = "../Modules/azurerm_load_balancer"
   

# }

