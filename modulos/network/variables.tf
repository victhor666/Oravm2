# variables para la parte de red
variable "nombre" {
  type=string
  default="Red-Oracle"
}
variable "vnet_cidr" {
  default = "192.168.0.0/16"
}
# INFO SUBNET
variable "subnet_cidr" {
  default = "192.168.10.0/24"
}
variable "resource_group_name" {
  default="${azurerm_resource_group.Rg.name}"
}
variable "location" {
  default="${azurerm_resource_group.Rg.location}"
}