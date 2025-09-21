data "azurerm_public_ip" "ip" {
  name                = "loadbalancer_ip"
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

resource "azurerm_lb_backend_address_pool" "pool" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "lb-BackEndAddressPool"
}


resource "azurerm_lb_probe" "example" {
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
}

