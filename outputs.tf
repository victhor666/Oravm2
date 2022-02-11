##########################################
#Información de la parte de red de azure##
##########################################
output "vnet_name" {
  description = "Nombre de la Vnet creada para el Oracle"
  value       = module.azure.vnetname
}
output "vnet_CIDR" {
  description = "CIDR de la vnet "
  value       = module.azure.vnetaddress
}

output "Subnet_Name" {
  description = "Nombre de la subred creada "
  value       = module.azure.subnetname
}

output "Subnet_CIDR" {
  description = "CIDR de la subnet "
  value       = module.azure.subnetprefix
}
output "vnet_dedicated_security_group_Name" {
  description = "Nombre del grupo de seguridad aplicado a la subred "
  value       = module.azure.sgname
}


##########################################
#Información de la parte de red de aws  ##
##########################################
# output "VPC Name" {
#   description = "Nombre de la Vnet creada para el Oracle"
#   value       = module.aws.vpc_Name
# }
# output "vpc_CIDR" {
#   description = "CIDR de la vnet "
#   value       = module.aws.vpc_CIDR
# }
# output "Subnet_Name" {
#   description = "Nombre de la subred creada "
#   value       = module.aws.Subnet_Name
# }
# output "Subnet_CIDR" {
#   description = "CIDR de la subnet "
#   value       = module.aws.Subnet_CIDR
# }