
#################
# VNET
#################
resource "azurerm_virtual_network" "Oracle_Vnet" {
  name                = "${var.Proyecto}-VNET"
  resource_group_name =var.resource_group_name
  location            =var.location
  address_space       = [var.vnet_cidr]
}
#################
# SUBREDES
#################
# aws_subnet.terra_sub:
resource "azurerm_subnet" "Oracle_Subnet" {
  name                 = "${var.Proyecto}-SUBNET"
  resource_group_name =var.resource_group_name
  location            =var.location
  virtual_network_name = azurerm_virtual_network.Oracle_Vnet.name
  address_prefixes     = [var.subnet_cidr]
}

######################
# GRUPOS DE SEGURIDAD
######################

resource "azurerm_network_security_group" "Oracle_Nsg" {
  name                = "${var.Proyecto}-NSG"
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