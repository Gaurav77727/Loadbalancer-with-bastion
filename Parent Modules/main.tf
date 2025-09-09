module "Resource-group" {
  source      = "../Child Modules/azurerm_resource_group"
  rg_name     = "lbrg"
  rg_location = "centralindia"
}

module "Vnet" {
  source     = "../Child Modules/azurerm_virtual_net"
  depends_on = [module.Resource-group]
  vnet_name  = "lbvnet"
  rg_name    = "lbrg"
  location   = "centralindia"
}

module "Subnet" {
  depends_on           = [module.Vnet]
  source               = "../Child Modules/azurerm_subnet"
  frontendsubnet1_name = "lbsubnet1"
  bastionsubnet_name   = "AzureBastionSubnet"
  frontendsubnet2_name = "lbsubnet2"
  rg_name              = "lbrg"
  vnet_name            = "lbvnet"
}

module "VM" {
  source        = "../Child Modules/azurerm_virtual_machine"
  depends_on    = [module.Subnet]
  nic_name      = "lbnic"
  location      = "centralindia"
  rg_name       = "lbrg"
  vm_name       = "nehavm"
  rg_location   = "centralindia"
  frontend_name = "lbsubnet1"
  vnet_name     = "lbvnet"
}

module "VM2" {
  source        = "../Child Modules/azurerm_virtual_machine"
  depends_on    = [module.VM]
  nic_name      = "lbnic2"
  location      = "centralindia"
  rg_name       = "lbrg"
  vm_name       = "mamtavm"
  rg_location   = "centralindia"
  frontend_name = "lbsubnet2"
  vnet_name     = "lbvnet"
}

module "Public-IP" {
  source      = "../Child Modules/azurerm_public_ip"
  depends_on  = [module.Resource-group]
  pip_name    = "lbpip"
  rg_name     = "lbrg"
  rg_location = "centralindia"
}

module "bastion" {
  source       = "../Child Modules/azurerm_bastion"
  depends_on   = [module.Public-IP, module.Resource-group]
  bastion_name = "AzureBastionSubnet"
  rg_name      = "lbrg"
  rg_location  = "centralindia"
  vnet_name    = "lbvnet"
}

module "loadbalancer" {
  source      = "../Child Modules/azurerm_loadbalancer"
  depends_on  = [module.Resource-group]
  rg_name     = "lbrg"
  rg_location = "centralindia"
}

module "neha-nicbapassociation" {
  source                = "../Child Modules/azurerm_nic_backend_pool_association"
  depends_on            = [module.loadbalancer]
  nic_name              = "lbnic"
  rg_name               = "lbrg"
  lb_name               = "ShivLoadBalancer"
  bap_name              = "lb-BackEndAddressPool"
  ip_configuration_name = "testconfiguration1"
}

module "mamta-nicbapassociation" {
  source                = "../Child Modules/azurerm_nic_backend_pool_association"
  depends_on            = [module.loadbalancer]
  nic_name              = "lbnic2"
  rg_name               = "lbrg"
  lb_name               = "ShivLoadBalancer"
  bap_name              = "lb-BackEndAddressPool"
  ip_configuration_name = "testconfiguration1"
}