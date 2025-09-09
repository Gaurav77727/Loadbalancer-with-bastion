data "azurerm_subnet" "frontendsubnet1" {
  name                 = var.frontend_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.rg_name
}