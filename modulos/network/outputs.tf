output "vnet_name" {
  description = "Nombre de la Vnet creada para el Oracle"
  value       = azurerm_virtual_network.Oracle_Vnet.name
}
output "vnet_CIDR" {
  description = "CIDR de la vnet "
  value       = azurerm_virtual_network.Oracle_Vnet.address_space
}

output "Subnet_Name" {
  description = "Nombre de la subred creada "
  value       = azurerm_subnet.Oracle_Subnet.name
}
output "Subnet_CIDR" {
  description = "CIDR de la subnet "
  value       = azurerm_subnet.Oracle_Subnet.address_prefixes
}
output "vnet_dedicated_security_group_Name" {
  description = "Nombre del grupo de seguridad aplicado a la subred "
  value       = azurerm_network_security_group.Oracle_Nsg.name
}
output "vnet_dedicated_security_ingress_rules" {
  description = "Reglas de entrada del grupo de seguridad "
  value       = azurerm_network_security_group.Oracle_Nsg.security_rule
}