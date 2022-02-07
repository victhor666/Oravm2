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
########################
##Provisioners Aqui podremos poner que copie ficheros de local al servidor o que se ejecuten tareas en remoto con remote-exec
########################
#  provisioner "file" {
#     source = "./main.tf"
#     destination = "/tmp/hola.txt"
#     connection {
#       type = "ssh"
#       user = "azureuser"
#       host = azurerm_linux_virtual_machine.OraVm.public_ip_address
#       private_key = file("~/orauser")
#       timeout  = "2m"
#     }
#   }
#  provisioner "file" {
#     source = "./main.tf"
#     destination = "/tmp/hola.txt"
#     connection {
#       type = "ssh"
#       user = "azureuser"
#       host = azurerm_linux_virtual_machine.OraVm.public_ip_address
#       private_key = file("~/orauser")
#       timeout  = "2m"
#     }
#   }

