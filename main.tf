terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.88.1"
    }
  }
}

provider "azurerm" {
  features {

  }
}
####################
# GRUPO DE RECURSOS#
####################
module  "RGora" {
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
 resource_group_name = module.RGora.rg_name_output
}

################################
# GRUPO DE Elementos de Computo#
################################

module "servidor" {
 source = "./modulos/server"
 Proyecto=var.Proyecto
 Location=var.Region
 resource_group_name = module.RGora.rg_name_output
 subnetid = module.red.subnetid
 network_security_group_id = module.red.sgid
}
