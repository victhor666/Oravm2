#variables para los nombres, tienen que venir del principal
variable="Proyecto"{
  type=string
}
variable "location" {
  type=string
}
variable "resource_group_name" {
  type=string
}

# variables para vnet
variable "vnet_cidr" {
  default = "192.168.0.0/16"
}
# INFO SUBNET
variable "subnet_cidr" {
  default = "192.168.10.0/24"
}

