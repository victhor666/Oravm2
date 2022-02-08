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
#############################
# GRUPO DE RECURSOS en azure#
#############################
module  "RGora" {
  source="./modulos/resourcegroup"
  Proyecto     = var.Proyecto
  Location = var.Region
}
#####################################
# GRUPO DE Elementos de red en azure#
#####################################

module "red" {
 source = "./modulos/network"
 Proyecto=var.Proyecto
 Location=var.Region
 resource_group_name = module.RGora.rg_name_output
}

#########################################
# GRUPO DE Elementos de Computo en azure#
#########################################

module "servidor" {
 source = "./modulos/server"
 Proyecto=var.Proyecto
 Location=var.Region
 resource_group_name = module.RGora.rg_name_output
 subnetid = module.red.subnetid
 network_security_group_id = module.red.sgid
}
#############################
# GRUPO DE RECURSOS en aws  #
#############################
provider "aws" {
  profile    = "${var.Profile}"
  region     = "${var.Region-aws}"
}

resource "aws_instance" "web-server" {
  ami           = "ami-0c2aba6c"
  instance_type = "t2.micro"
}