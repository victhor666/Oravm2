output "vnetname" {
  description = "Nombre de la Vnet creada para el Oracle"
  value       = azurerm_virtual_network.Oracle-VNET.name
}
output "vnetid" {
  description = "Nombre de la Vnet creada para el Oracle"
  value       = azurerm_virtual_network.Oracle-VNET.id
}
output "vnetaddress" {
  description = "CIDR de la vnet "
  value       = azurerm_virtual_network.Oracle-VNET.address_space
}
output "sgname" {
  description = "Nombre de la subnet "
  value       = azurerm_subnet.Oracle-SUBNET.name
}
output "subnetname" {
  description = "Nombre de la subred creada "
  value       = azurerm_subnet.Oracle-SUBNET.name
}
output "subnetid" {
  description = "Nombre de la subred creada "
  value       = azurerm_subnet.Oracle-SUBNET.id
}
output "subnetprefix" {
  description = "CIDR de la subnet "
  value       = azurerm_subnet.Oracle-SUBNET.address_prefixes
}

