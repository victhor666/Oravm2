# Aws account region and autehntication 
#variable "aws_access_key" {}
#variable "aws_secret_key" {}
variable "Proyecto" {
    default = "Oracle"
}

variable "Location" {
    default = "eu-central-1"
}
# VPC INFO
    
    variable "vpc_cidr" {
      default = "192.168.0.0/16"
    }

# SUBNET INFO

    variable "subnet_cidr"{
      default = "192.168.10.0/24"
      } 
    variable "map_public_ip_on_launch" { 
      description = "Se le asigna una ip publica al desplegar o no. "
      default = true   
    }  

