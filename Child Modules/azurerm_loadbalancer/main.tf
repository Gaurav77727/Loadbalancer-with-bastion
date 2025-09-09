resource "azurerm_public_ip" "lbpip" {
  name                = "PublicIPForLB"
  location            = var.rg_location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
}

resource "azurerm_lb" "lb" {
  name                = "ShivLoadBalancer"
  location            = var.rg_location
  resource_group_name = var.rg_name

  frontend_ip_configuration {
    name                 = "NetflixPublicIPAddress"
    public_ip_address_id = azurerm_public_ip.lbpip.id
  }
}

resource "azurerm_lb_backend_address_pool" "pool1" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "lb-BackEndAddressPool"
}

resource "azurerm_lb_probe" "probe" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "Netflix-probe"
  port            = 80
}

resource "azurerm_lb_rule" "lb-rule" {
  loadbalancer_id                = azurerm_lb.lb.id
  name                           = "NetflixLBRule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "NetflixPublicIPAddress"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.pool1.id] # ye add kra hai bhai arguments se block ke andhar
  probe_id                       = azurerm_lb_probe.probe.id # ye add kra hai bhai arguments se block ke andhar lb rule block ke yha se
}
