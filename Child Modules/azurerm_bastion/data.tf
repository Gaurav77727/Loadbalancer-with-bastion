data "azurerm_subnet" "bastionsubnet" {
  name                 = "AzureBastionSubnet"
  virtual_network_name = "lbvnet"
  resource_group_name  = "lbrg"
}

data "azurerm_public_ip" "pip" {
  name                = "lbpip"
  resource_group_name = "lbrg"
}