
#################
# VNET
#################
resource "azurerm_virtual_network" "Oracle_Vnet" {
  name                = "${var.nombre}-VNET"
  resource_group_name = azurerm_resource_group.Rg.name
  location            = azurerm_resource_group.Rg.location
  address_space       = [var.vnet_cidr]
}
#################
# SUBREDES
#################
# aws_subnet.terra_sub:
resource "azurerm_subnet" "Oracle_Subnet" {
  name                 = "${var.nombre}-SUBNET"
  virtual_network_name = azurerm_virtual_network.Oracle_Vnet.name
  resource_group_name  = azurerm_resource_group.Rg.name
  address_prefixes     = [var.subnet_cidr]
}

######################
# GRUPOS DE SEGURIDAD
######################

resource "azurerm_network_security_group" "Oracle_Nsg" {
  name                = "${var.nombre}-NSG"
  location            = azurerm_resource_group.Rg.location
  resource_group_name = azurerm_resource_group.Rg.name

  security_rule {
    name                       = "Salida"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    description                = "Salida a internet sin restricciones. Debe ser modificado mas adelante"
  }
  security_rule {
    name                       = "Entrada http-https y ssh desde cualquier sitio"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["22", "80", "443"]
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    description                = "SSH-HTTP-HTTPS desde any"
  }


  tags = {
    Name = "SSH ,HTTP, and HTTPS"
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg_sub" {
  subnet_id                 = azurerm_subnet.Oracle_Subnet.id
  network_security_group_id = azurerm_network_security_group.Oracle_Nsg.id
}