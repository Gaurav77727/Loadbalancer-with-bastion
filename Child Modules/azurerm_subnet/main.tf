resource "azurerm_subnet" "frontendsubnet1" {
  name                 = var.frontendsubnet1_name
  resource_group_name  = var.rg_name
  virtual_network_name = var.vnet_name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "bastionsubnet" {
  name                 = var.bastionsubnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = var.vnet_name
  address_prefixes     = ["10.0.3.0/24"]
}

resource "azurerm_subnet" "frontendsubnet2" {
  name                 = var.frontendsubnet2_name
  resource_group_name  = var.rg_name
  virtual_network_name = var.vnet_name
  address_prefixes     = ["10.0.2.0/24"]
}
