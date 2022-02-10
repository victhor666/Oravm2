#################
# VNET
#################
resource "azurerm_virtual_network" "Oracle_Vnet" {
  name                = "${var.Proyecto}-VNET"
  resource_group_name =var.resource_group_name
  location            =var.Location
  address_space       = [var.vnet_cidr]
}
#################
# SUBREDES
#################
resource "azurerm_subnet" "Oracle_Subnet" {
  name                 = "${var.Proyecto}-SUBNET"
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.Oracle_Vnet.name
  address_prefixes     = [var.subnet_cidr]
}

######################
# GRUPOS DE SEGURIDAD
######################

resource "azurerm_network_security_group" "Oracle_Nsg" {
  name                = "${var.Proyecto}-NSG"
  location            =var.Location
  resource_group_name = var.resource_group_name
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

######################
# SERVIDOR
######################


resource "azurerm_network_interface" "OraNic" {
  name                = "${var.Proyecto}-nic"
  location            = var.Location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "Configuracion_ip"
    subnet_id                     = var.subnetid
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.IpPublica.id
  }
}
resource "azurerm_public_ip" "IpPublica" {
  name                = "IP-Publica"
  location            = var.Location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"

  tags = {
    app = "IP-publica "
  }
}

resource "azurerm_network_interface_security_group_association" "AsocSG" {
  network_interface_id      = azurerm_network_interface.OraNic.id
  network_security_group_id = var.network_security_group_id
}
resource "azurerm_linux_virtual_machine" "OraVm" {
  name                            = "${var.Proyecto}-vm"
  location            = var.Location
  resource_group_name = var.resource_group_name
  network_interface_ids           = [azurerm_network_interface.OraNic.id]
  size                            = var.vm_size
  computer_name                   = "OracleVM"
  admin_username                  = "azureuser"
  disable_password_authentication = true
  provision_vm_agent              = true
  custom_data                     = base64encode("${file(var.user_data)}")


  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/Oravm2/orauser.pub")
  }
  ######################
  # IMAGEN
  ######################
  source_image_reference {
    publisher = var.os_publisher[var.OS].publisher
    offer     = var.os_publisher[var.OS].offer
    sku       = var.os_publisher[var.OS].sku
    version   = "latest"
  }
 ######################
  # VOLUMEN
  ######################
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = var.osdisk_size
    }
  }
