resource "azurerm_resource_group" "Rg" {
  name     = "${var.Proyecto}RG"
  location = var.Location
}
