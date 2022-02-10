output "vnetname" {
  description = "Nombre de la Vnet creada para el Oracle"
  value       = azurerm_virtual_network.Oracle_Vnet.name
}
output "vnetid" {
  description = "Nombre de la Vnet creada para el Oracle"
  value       = azurerm_virtual_network.Oracle_Vnet.id
}
output "vnetaddress" {
  description = "CIDR de la vnet "
  value       = azurerm_virtual_network.Oracle_Vnet.address_space
}

output "subnetname" {
  description = "Nombre de la subred creada "
  value       = azurerm_subnet.Oracle_Subnet.name
}
output "subnetid" {
  description = "Nombre de la subred creada "
  value       = azurerm_subnet.Oracle_Subnet.id
}
output "subnetprefix" {
  description = "CIDR de la subnet "
  value       = azurerm_subnet.Oracle_Subnet.address_prefixes
}
output "sgname" {
  description = "Nombre del grupo de seguridad aplicado a la subred "
  value       = azurerm_network_security_group.Oracle_Nsg.name
}
output "sgid" {
  description = "Nombre del id  de seguridad aplicado a la subred "
  value       = azurerm_network_security_group.Oracle_Nsg.id
}
output "sgirules" {
  description = "Reglas de entrada del grupo de seguridad "
  value       = azurerm_network_security_group.Oracle_Nsg.security_rule
}
