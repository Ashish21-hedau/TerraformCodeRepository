rg_module = {
  rg1 = {
    resource_group_name = "dev-ashishrg1"
    location            = "North Europe"
    tags = {
      Enviorment = "terraform ke kiye"
  } }
}
stg_module = {
  stg1 = {
    storage_account_name     = "devikeekkastorahe"
    resource_group_name      = "dev-ashishrg1"
    location                 = "North Europe"
    account_tier             = "Standard"
    account_replication_type = "GRS"
    tags = {
      environment = "staging"
    }
  }
}
vnet_module = {
  vnet1 = {
    vnet_name           = "dev-vnetsubnet"
    location            = "North Europe"
    resource_group_name = "dev-ashishrg1"
    address_space       = ["10.0.0.0/16"]
    tags = {
      Enviorment = "vnet1keliye"
    }
    subnet = [{
      address_prefixes = ["10.0.1.0/24"]
      subnet_name      = "fronted-subnet"
      },
      {
        address_prefixes = ["10.0.2.0/24"]
        subnet_name      = "backend-subnet"
      },
      {
        address_prefixes = ["10.0.3.0/27"]
        subnet_name      = "AzureBastionSubnet"
      }
] } }
pip_module = {
  pip1 = {
    pip_name            = "dev-pip1"
    resource_group_name = "dev-ashishrg1"
    location            = "North Europe"
    allocation_method   = "Static"
    tags = {
      environment = "Dev envortmnt ke liye1"
    }
  }
  pip2 = {
    pip_name            = "dev-pip2"
    resource_group_name = "dev-ashishrg1"
    location            = "North Europe"
    allocation_method   = "Static"
    tags = {
      environment = "Dev envortmnt ke liye2"
    }
  }
  pip3 = {
    pip_name            = "dev-pip3"
    resource_group_name = "dev-ashishrg1"
    location            = "North Europe"
    allocation_method   = "Static"
    tags = {
      environment = "Dev envortmnt ke liye3"
    }
  }
}
nic_module = {
  nic1 = {
    nic_name            = "dev-tatagorup-nic"
    location            = "North Europe"
    resource_group_name = "dev-ashishrg1"
    subnet_name         = "fronted-subnet"
    vnet_name           = "dev-vnetsubnet"
    pip_name            = "dev-pip1"
    ip_configuration = [{
      ip_configuration_name         = "internal"
      private_ip_address_allocation = "Dynamic"
    }]
  }
  nic2 = {
    nic_name            = "dev-tatagorup-nicok"
    location            = "North Europe"
    resource_group_name = "dev-ashishrg1"
    subnet_name         = "backend-subnet"
    vnet_name           = "dev-vnetsubnet"
    pip_name            = "dev-pip2"

    ip_configuration = [{
      ip_configuration_name         = "internal"
      private_ip_address_allocation = "Dynamic"
    }]
  }
}
linuxvms_moudle = {
  VM1 = {
    vm_name                         = "dev-vm1"
    resource_group_name             = "dev-ashishrg1"
    location                        = "North Europe"
    vm_size                         = "Standard_D2ds_v4"
    admin_username                  = "Ashish51"
    admin_password                  = "Megha@#21051990"
    script_name                     = "nginx.sh"
    disable_password_authentication = false

    nic_name = "dev-tatagorup-nic"
    nsg_name = "dev-nsg1"
    os_disk = [{
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }]
    source_image_reference = [{
      vm_publisher = "Canonical"
      vm_offer     = "0001-com-ubuntu-server-jammy"
      vm_sku       = "22_04-lts"
      vm_version   = "latest"
    }]
  }
  VM2 = {
    vm_name                         = "dev-vm2"
    resource_group_name             = "dev-ashishrg1"
    location                        = "North Europe"
    vm_size                         = "Standard_D2ds_v4"
    admin_username                  = "Ashish52"
    admin_password                  = "Megha@#21051990"
    disable_password_authentication = false
    nic_name                        = "dev-tatagorup-nicok"
    nsg_name                        = "dev-nsg2"
    script_name                     = "nginx.sh"
    os_disk = [{
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }]
    source_image_reference = [{
      vm_publisher = "Canonical"
      vm_offer     = "0001-com-ubuntu-server-jammy"
      vm_sku       = "22_04-lts"
      vm_version   = "latest"
    }]
  }
}
nsg_module = {
  nsg1 = {
    nsg_name            = "dev-nsg1"
    location            = "North Europe"
    resource_group_name = "dev-ashishrg1"
    tags = {
      Envement = "Nsg rule ke liye"
    }
    security_rule = [{
      security_rule_name                       = "Allow-HTTP"
      security_rule_priority                   = 100
      security_rule_direction                  = "Inbound"
      security_rule_access                     = "Allow"
      security_rule_protocol                   = "Tcp"
      security_rule_source_port_range          = "*"
      security_rule_source_address_prefix      = "*"
      security_rule_destination_port_range     = "80"
      security_rule_destination_address_prefix = "*"
      },
      {
        security_rule_name                       = "Allow-SSH"
        security_rule_priority                   = 110
        security_rule_direction                  = "Inbound"
        security_rule_access                     = "Allow"
        security_rule_protocol                   = "Tcp"
        security_rule_source_port_range          = "*"
        security_rule_source_address_prefix      = "*"
        security_rule_destination_port_range     = "22"
        security_rule_destination_address_prefix = "*"
      }
    ]
  }
  nsg2 = {
    nsg_name            = "dev-nsg2"
    location            = "North Europe"
    resource_group_name = "dev-ashishrg1"
    tags = {
      Envement = "Nsg rule ke liye"
    }
    security_rule = [
      {
        security_rule_name                       = "Allow-RDP"
        security_rule_priority                   = 120
        security_rule_direction                  = "Inbound"
        security_rule_access                     = "Allow"
        security_rule_protocol                   = "Tcp"
        security_rule_source_port_range          = "*"
        security_rule_source_address_prefix      = "*"
        security_rule_destination_port_range     = "80"
        security_rule_destination_address_prefix = "*"
      },
      {
        security_rule_name                       = "Allow-HTTP"
        security_rule_priority                   = 121
        security_rule_direction                  = "Inbound"
        security_rule_access                     = "Allow"
        security_rule_protocol                   = "Tcp"
        security_rule_source_port_range          = "*"
        security_rule_source_address_prefix      = "*"
        security_rule_destination_port_range     = "22"
        security_rule_destination_address_prefix = "*"
      }
    ]
  }
}
nsgassocations_module = {
  nsgacc1 = {
    nsg_name            = "dev-nsg1"
    nic_name            = "dev-tatagorup-nic"
    resource_group_name = "dev-ashishrg1"
  }
  nsgacc2 = {
    nsg_name            = "dev-nsg2"
    nic_name            = "dev-tatagorup-nicok"
    resource_group_name = "dev-ashishrg1"
  }
}
mssqlserver_moudle = {
  mssqlserver1 = {
    mssqlserver_name             = "dev-mssserverashishhedau"
    resource_group_name          = "dev-ashishrg1"
    location                     = "North Europe"
    version                      = "12.0"
    administrator_login          = "Ashish53"
    administrator_login_password = "Megha@#1993"
    minimum_tls_version          = "1.2"
    tags = {
      terraduation = "server ke liye"
    }
  }
}
mssqldatabases_moudle = {
  mssqldatabase1 = {
    mssqldatabase_name  = "dev-mssserverashishkumar"
    resource_group_name = "dev-ashishrg1"
    collation           = "SQL_Latin1_General_CP1_CI_AS"
    license_type        = "LicenseIncluded"
    max_size_gb         = 2
    sku_name            = "S0"
    enclave_type        = "VBS"
    mssqlserver_name    = "dev-mssserverashishhedau"
    tags = {
      foo = "bar"
    }
  }
}

bsthost_module = {
  bsthost1 = {
    bastionhost_name    = "dev-vmbastion566"
    location            = "North Europe"
    subnet_name         = "AzureBastionSubnet"
    vnet_name           = "dev-vnetsubnet"
    resource_group_name = "dev-ashishrg1"
    pip_name            = "dev-pip3"
    ip_configuration = [{
      ip_configuration_name = "configuration"
    }]
  }
}
