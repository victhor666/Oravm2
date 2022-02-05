provider "azurerm" {
  features {}
}

####################
# GRUPO DE RECURSOS#
####################
resource "azurerm_resource_group" "Rg" {
  name     = "${var.Rg}"
  location = "${var.Region}"
}

# module "red" {
#  source = "./modulos/network"
#  Grupo_Recursos=azurerm_resource_group.Rg.name
# }