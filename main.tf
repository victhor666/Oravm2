terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.88.1"
    }
  }
}
#########################################
# SERVIDOR ORACLE EN AZURE              #
#########################################
provider "azurerm" {
  features {

  }
}
    module "azure" {
    source = "./azure"
    Proyecto=var.Proyecto
    Region=var.Region
    }
#############################
# SERVIDOR ORACLE EN AWS    #
#############################
# provider "aws" {
#   profile    = "${var.Profile}"
#   region     = "${var.Region-aws}"
# }

#  module "aws" {
#  source = "./aws"
#  Proyecto=var.Proyecto
#  Location=var.Region-aws
#  }