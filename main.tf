provider "azurerm" {
  features {}
}

####################
# GRUPO DE RECURSOS#
####################
resource "azurerm_resource_group" "Rg" {
  name     = "${var.Proyecto}RG"
  Location = var.Region
}
############################
# GRUPO DE Elementos de red#
############################

module "red" {
 source = "./modulos/network"
 Proyecto=var.Proyecto
 Location=var.Region
 resource_group_name = "module.resources.rg_name_output"
}