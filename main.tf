provider "azurerm" {
  features {}
}

####################
# GRUPO DE RECURSOS#
####################
module  "resourcegroup" {
  source="./modulos/resourcegroup"
  Proyecto     = var.Proyecto
  Location = var.Region
}
############################
# GRUPO DE Elementos de red#
############################

module "red" {
 source = "./modulos/network"
 Proyecto=var.Proyecto
 Location=var.Region
 resource_group_name = "module.resourcegroup.rg_name_output"
}