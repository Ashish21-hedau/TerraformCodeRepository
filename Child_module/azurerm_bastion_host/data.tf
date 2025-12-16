data "azurerm_subnet" "subnet" {
      for_each = var.bsthosts
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.resource_group_name
}
  
# output "subnet_id" {
#   value = data.azurerm_subnet.example.id
# }

data "azurerm_public_ip" "pip" {
    for_each = var.bsthosts
  name                = each.value.pip_name
  resource_group_name = each.value.resource_group_name
}

# output "domain_name_label" {
#   value = data.azurerm_public_ip.example.domain_name_label
# }

# output "public_ip_address" {
#   value = data.azurerm_public_ip.example.ip_address
# }

