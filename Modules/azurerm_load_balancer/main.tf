resource "azurerm_lb" "lb" {
  name                = var.lb_name
  location            = var.location
  resource_group_name = var.resource_group_name

  frontend_ip_configuration {
    name                 = var.frontend_ip_name
    public_ip_address_id = data.azurerm_public_ip.pip1.id
  }

}

data "azurerm_public_ip" "pip1" {  
  name                = var.public_ip_name
  resource_group_name = var.resource_group_name
  
}

resource "azurerm_lb_probe" "lb_probe" {
  name                = var.probe_name
  loadbalancer_id     = azurerm_lb.lb.id  
  port                = 80
  
}


resource "azurerm_lb_backend_address_pool" "my_backend_pool" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = var.my_backend_pool
  
}

resource "azurerm_lb_rule" "lb_rule" {
  loadbalancer_id            = azurerm_lb.lb.id
  name                       = var.lb_rule
  protocol                   = "Tcp"
  frontend_port              = 80
  backend_port               = 80
  frontend_ip_configuration_name = var.frontend_ip_name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.my_backend_pool.id]
  probe_id                      = azurerm_lb_probe.lb_probe.id
  
}

