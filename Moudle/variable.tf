variable "rg_module" {
  type = map(object({
    resource_group_name = string
    location            = string
    tags                = map(string)
  }))
}
variable "stg_module" {
  type = map(object({
    storage_account_name     = string
    resource_group_name      = string
    location                 = string
    account_tier             = string
    account_replication_type = string
    tags                     = map(string)
  }))
}

variable "vnet_module" {
  type = map(object({
    vnet_name           = string
    location            = string
    resource_group_name = string
    address_space       = list(string)
    tags                = map(string)
    subnet = list(object({
      subnet_name      = string
      address_prefixes = list(string)
    }))
  }))
}
variable "pip_module" {
  type = map(object({
    pip_name            = string
    resource_group_name = string
    location            = string
    allocation_method   = string
    tags                = map(string)
  }))
}

variable "nic_module" {
  type = map(object({
    nic_name            = string
    location            = string
    resource_group_name = string
    subnet_name         = string
    vnet_name           = string
    pip_name            = string
    ip_configuration = list(object({
      ip_configuration_name         = string
      private_ip_address_allocation = string
    }))
  }))
}

variable "linuxvms_moudle" {
  type = map(object({
    vm_name                         = string
    resource_group_name             = string
    location                        = string
    vm_size                         = string
    admin_username                  = string
    admin_password                  = string
    disable_password_authentication = string
    nic_name                        = string
    nsg_name                        = string
    script_name                     = string
    os_disk = list(object({
      caching              = string
      storage_account_type = string
    }))
    source_image_reference = list(object({
      vm_publisher = string
      vm_offer     = string
      vm_sku       = string
      vm_version   = string
    }))
  }))
}

variable "nsg_module" {
  type = map(object({
    nsg_name            = string
    location            = string
    resource_group_name = string
    tags                = map(string)
    security_rule = list(object({
      security_rule_name                       = string
      security_rule_priority                   = number
      security_rule_direction                  = string
      security_rule_access                     = string
      security_rule_protocol                   = string
      security_rule_source_port_range          = string
      security_rule_destination_port_range     = string
      security_rule_source_address_prefix      = string
      security_rule_destination_address_prefix = string

    }))
  }))
}

variable "nsgassocations_module" {
  type = map(object({
    nsg_name            = string
    nic_name            = string
    resource_group_name = string
  }))
}

variable "mssqlserver_moudle" {
  type = map(object({
    mssqlserver_name             = string
    resource_group_name          = string
    location                     = string
    version                      = string
    administrator_login          = string
    administrator_login_password = string
    minimum_tls_version          = string
    tags                         = map(string)
  }))
}

variable "mssqldatabases_moudle" {
  type = map(object({
    mssqldatabase_name  = string
    resource_group_name = string
    collation           = string
    license_type        = string
    max_size_gb         = number
    sku_name            = string
    enclave_type        = string
    mssqlserver_name    = string
    tags                = map(string)
  }))
}


variable "bsthost_module" {
  type = map(object({
    bastionhost_name    = string
    location            = string
    subnet_name         = string
    vnet_name           = string
    resource_group_name = string
    pip_name            = string
    ip_configuration = list(object({
      ip_configuration_name = string
    }))
  }))
}
