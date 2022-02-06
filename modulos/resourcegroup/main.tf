resource "azurerm_resource_group" "Rg" {
  name     = "${var.proyecto}RG"
  location = var.location
}
