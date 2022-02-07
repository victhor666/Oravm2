variable "Region" {
  type=string
  default="eastus"
}
variable "Proyecto" {
  type=string
  default="Oracle"
}
variable "Vnet" {
  type = string
  description = "ID de la vnet existente"
}