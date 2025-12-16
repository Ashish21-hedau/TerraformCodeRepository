module "rg" {
  source = "../Child_module/azurerm_resource_group"
  rgs    = var.rg_module
}
module "stg" {
  source     = "../Child_module/azurerm_storage_account"
  stgs       = var.stg_module
  depends_on = [module.rg]
}
module "vnet" {
  source     = "../Child_module/azurerm_virtual_network"
  vnets      = var.vnet_module
  depends_on = [module.rg]
}

module "pip" {
  source     = "../Child_module/azurerm_public_ip"
  pips       = var.pip_module
  depends_on = [module.rg]
}

module "nic" {
  source     = "../Child_module/azurerm_network_interface"
  nics       = var.nic_module
  depends_on = [module.vnet, module.rg, module.pip]
}

module "linuxvm" {
  source     = "../Child_module/azurerm_linux_virtual_machine"
  linuxvms   = var.linuxvms_moudle
  depends_on = [module.nic]
}

module "nsg" {
  source     = "../Child_module/azurerm_network_security_group"
  nsgs       = var.nsg_module
  depends_on = [module.rg]
}

module "netsecass" {
  source         = "../Child_module/azurerm_network_interface_security_group_association"
  nsgassocations = var.nsgassocations_module
  depends_on     = [module.nic, module.nsg, module.rg]
}

module "mssqlserver" {
  source       = "../Child_module/azurerm_mssql_server"
  mssqlservers = var.mssqlserver_moudle
}

module "mssqldatbse" {
  source         = "../Child_module/azurerm_mssql_database"
  mssqldatabases = var.mssqldatabases_moudle
  depends_on     = [module.mssqlserver]
}

module "bsthost" {
  source     = "../Child_module/azurerm_bastion_host"
  bsthosts   = var.bsthost_module
  depends_on = [module.pip, module.vnet, ]
}


