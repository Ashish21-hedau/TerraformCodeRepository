resource "azurerm_bastion_host" "bsthost" {
    for_each = var.bsthosts
  name                = each.value.bastionhost_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

   dynamic "ip_configuration" {
    for_each = each.value.ip_configuration
    content {
    name                 = ip_configuration.value.ip_configuration_name
    subnet_id            = data.azurerm_subnet.subnet[each.key].id
    public_ip_address_id = data.azurerm_public_ip.pip[each.key].id
    }
  }
}  
