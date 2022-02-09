 terraform {
      required_version = ">= 0.12.0"
    }
# Provider specific configs
#provider "aws" {
#    access_key = "${var.aws_access_key}"
#    secret_key = "${var.aws_secret_key}"
#    region = var.Region-aws
#}
###########################################
# Datos de las zonas de  de disponibilidad 
###########################################
data "aws_availability_zones" "Oracle-AD" {
  state = "available"
  filter {
    name   = "region-name"
    values =[var.Location]
  }
}    
#################
# VPC
#################
resource "aws_vpc" "Oracle-VPC" {
    cidr_block                       = var.vpc_cidr
    tags                             = {
        "Name" = "${var.Proyecto}-VPC"
    }
}
#################
# SUBNET
#################

resource "aws_subnet" "Oracle-SUBNET" {
    vpc_id                          = aws_vpc.Oracle-VPC.id
    availability_zone               = data.aws_availability_zones.Oracle-AD.names[0]
    cidr_block                      = var.subnet_cidr
    map_public_ip_on_launch         = var.map_public_ip_on_launch
    tags                            = {
        "Name" = "${var.Proyecto}-SUBNET"
    }
}
######################
# Internet Gateway
###################### 
# aws_internet_gateway.terra_igw:
resource "aws_internet_gateway" "Oracle-IGW" {
    vpc_id   = aws_vpc.Oracle-VPC.id
    tags     = {
        "Name" = "${var.Proyecto}-IGW"
    }
}
######################
# Route Table
###################### 

resource "aws_route_table" "Oracle-ROUTETABLE" {
    vpc_id  = aws_vpc.Oracle-VPC.id
    route  {
            cidr_block   = "0.0.0.0/0"
            gateway_id   = aws_internet_gateway.Oracle-IGW.id
        }
    
    tags             = {
        "Name" = "${var.Proyecto}-ROUTETABLE"
    }

}

resource "aws_route_table_association" "RouteTable-Asociacion" {
    route_table_id = aws_route_table.Oracle-ROUTETABLE.id
    subnet_id      = aws_subnet.Oracle-SUBNET.id
}

######################
# Security Group
######################    

resource "aws_security_group" "Oracle-SG" {
    name        = "${var.Proyecto}-SG"
    vpc_id      = aws_vpc.Oracle-VPC.id
    description = "SSH ,HTTP, and HTTPS"
    egress {
            cidr_blocks      = [
                "0.0.0.0/0",
            ]
            description      = "Salida por defecto permitido a todo"
            from_port        = 0
            protocol         = "-1"
            to_port          = 0
            self             = false
        }
    
    ingress     = [
        {
            cidr_blocks      = [
                "0.0.0.0/0",
            ]
            description      = "Entrada HTTPS "
            from_port        = 443
            protocol         = "tcp"
            to_port          = 443
            prefix_list_ids  = null 
            ipv6_cidr_blocks = null 
            security_groups  = null 
            self             = false
            
        },
        {
            cidr_blocks      = [
                "0.0.0.0/0",
            ]
            description      = "Entrada ssh"
            from_port        = 22
            protocol         = "tcp"
            security_groups  = []
            to_port          = 22
             prefix_list_ids  = null 
            ipv6_cidr_blocks = null  
            security_groups  = null  
            self             = false 
        },
    ]
    tags = {
    Name = "${var.Proyecto}-RG"
  }

}