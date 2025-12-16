resource "azurerm_linux_virtual_machine" "linuxvm" {
    for_each = var.linuxvms
  name                = each.value.vm_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  size                = each.value.vm_size
  admin_username      = each.value.admin_username
  admin_password = each.value.admin_password
  custom_data = base64encode(file(each.value.script_name))
  network_interface_ids = [data.azurerm_network_interface.nic[each.key].id,]
 disable_password_authentication = each.value.disable_password_authentication
  
   dynamic "os_disk" {
    for_each = each.value.os_disk
    content {
    caching              = os_disk.value.caching
    storage_account_type = os_disk.value.storage_account_type
    }
  }

   dynamic "source_image_reference" {
    for_each = each.value.source_image_reference
    content {
    publisher = source_image_reference.value.vm_publisher
    offer     = source_image_reference.value.vm_offer 
    sku       = source_image_reference.value.vm_sku
    version   = source_image_reference.value.vm_version
    }
  }
}


  