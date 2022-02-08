#variables para azure
variable "Region" {
  type=string
  default="eastus"
}
variable "Proyecto" {
  type=string
  default="Oracle"
}
#variables para aws
variable "Region-aws" {
  type=string
  default=""
}
variable "Profile" {
  type=string
  default="default"
}
