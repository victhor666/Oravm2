#################################
# GRUPO DE RECURSOS            ##
#################################
resource "azurerm_resource_group" "RG" {
  name     = "${var.Proyecto}-RG"
  location = var.Location
}

############################
# VNET                    ##
############################
resource "azurerm_virtual_network" "Oracle-VNET" {
  name                = "${var.Proyecto}-VNET"
  resource_group_name = azurerm_resource_group.RG.name
  location            = azurerm_resource_group.RG.location
  address_space       = [var.vnet_cidr]
}
#################
# SUBREDES
#################
resource "azurerm_subnet" "Oracle-SUBNET" {
  name                 = "${var.Proyecto}-SUBNET"
  resource_group_name = azurerm_resource_group.RG.name
  virtual_network_name = azurerm_virtual_network.Oracle-VNET.name
  address_prefixes     = [var.subnet_cidr]
}

######################
# GRUPOS DE SEGURIDAD
######################

resource "azurerm_network_security_group" "Oracle-NSG" {
  name                = "${var.Proyecto}-NSG"
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
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

resource "azurerm_subnet_network_security_group_association" "NSG-SUB" {
  subnet_id                 = azurerm_subnet.Oracle-SUBNET.id
  network_security_group_id = azurerm_network_security_group.Oracle-NSG.id
}

######################
# SERVIDOR
######################


resource "azurerm_network_interface" "OraNic" {
  name                = "${var.Proyecto}-NIC"
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name

  ip_configuration {
    name                          = "Configuracion-IP"
    subnet_id                     = azurerm_subnet.Oracle-SUBNET.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.IpPublica.id
  }
}
resource "azurerm_public_ip" "IpPublica" {
  name                = "IP-Publica"
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface_security_group_association" "AsocSG" {
  network_interface_id      = azurerm_network_interface.OraNic.id
  network_security_group_id = azurerm_network_security_group.Oracle-NSG.id
}
resource "azurerm_linux_virtual_machine" "OraVm" {
  name                            = "${var.Proyecto}-VM"
  location                        = azurerm_resource_group.RG.location
  resource_group_name             = azurerm_resource_group.RG.name
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
#################################
## Agregamos un disco adicional##
#################################

resource "azurerm_managed_disk" "disco2" {
  name                            = "${var.Proyecto}-vm-disco2"
  location                        = azurerm_resource_group.RG.location
  resource_group_name             = azurerm_resource_group.RG.name
  storage_account_type            = "Standard_LRS"
  create_option                   = "Empty"
  disk_size_gb                    = var.disco2_size
}
resource "azurerm_managed_disk" "disco3" {
  name                            = "${var.Proyecto}-vm-disco3"
  location                        = azurerm_resource_group.RG.location
  resource_group_name             = azurerm_resource_group.RG.name
  storage_account_type            = "Standard_LRS"
  create_option                   = "Empty"
  disk_size_gb                    = var.disco3_size
}
#Las esperas son por que no se si hay forma de asignar letras concretas a los volumenes (como en aws) así que los montamos por orden
resource "null_resource" "previous" {}

resource "time_sleep" "wait_90_seconds" {
  depends_on = [null_resource.previous]

  create_duration = "90s"
}

resource "azurerm_virtual_machine_data_disk_attachment" "disco2" {
  managed_disk_id    = azurerm_managed_disk.disco2.id
  virtual_machine_id = azurerm_linux_virtual_machine.OraVm.id
  lun                = "1"
  caching            = "ReadWrite"
depends_on = [null_resource.previous]
}


resource "azurerm_virtual_machine_data_disk_attachment" "disco3" {
  managed_disk_id    = azurerm_managed_disk.disco3.id
  virtual_machine_id = azurerm_linux_virtual_machine.OraVm.id
  lun                = "2"
  caching            = "ReadWrite"
  depends_on =[azurerm_virtual_machine_data_disk_attachment.disco2]
}