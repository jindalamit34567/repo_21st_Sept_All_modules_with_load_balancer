data "azurerm_public_ip" "ip" {
  name                = "myPublicIP"
  resource_group_name = "ajindal-rg"
}


resource "azurerm_lb" "lb" {
  name                = "my-LoadBalancer"
  location            = "central India"
  resource_group_name = "ajindal-rg"

  frontend_ip_configuration {
    name                 = "myPublicIPAddress"
    public_ip_address_id = data.azurerm_public_ip.ip.id
  }
}

resource "azurerm_lb_backend_address_pool" "pool1" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "lb-BackEndAddressPool"
}


resource "azurerm_lb_probe" "my-probe" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "my-probe"
  port            = 80
}

# ip and port based routing

resource "azurerm_lb_rule" "lb_rule" {
  loadbalancer_id                = azurerm_lb.lb.id
  name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "myPublicIPAddress"
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.pool1.id]
  probe_id                       = azurerm_lb_probe.my-probe.id

}



