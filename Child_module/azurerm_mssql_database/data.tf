data "azurerm_mssql_server" "mssqlserver" {
    for_each = var.mssqldatabases
  name                = each.value.mssqlserver_name
  resource_group_name = each.value.resource_group_name
}



