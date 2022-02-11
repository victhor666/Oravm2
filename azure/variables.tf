#variables para los nombres, tienen que venir del principal
#############
# GENERALES #
#############
variable "Proyecto"{
  type=string
}
variable "Location" {
  type=string
}
variable "resource_group_name" {
  type=string
}
###########################
# variables para vnet
###########################
variable "vnet_cidr" {
  default = "192.168.0.0/16"
}
# INFO SUBNET
variable "subnet_cidr" {
  default = "192.168.10.0/24"
}
#########
#SERVIDOR
#########

variable  "subnetid"{
type=string
}
variable "network_security_group_id"{
    type=string
}

variable "osdisk_size" {
  default = "30"
}
 variable "disco2_size" {
   default = "25"
 }
 variable "disco3_size" {
   default = "10"
 }
variable "vm_size" {
  default = "Standard_B2ms"
}

variable "os_publisher" {
  default = {
    OL7 = {
      publisher = "Oracle"
      offer     = "Oracle-Linux"
      sku       = "79-gen2"
    },
    UBUNTU       =  {
      publisher = "Canonical"
      offer     = "UbuntuServer"
      sku       = "19_10-daily-gen2"
      admin     = "azureuser"
    }
  }
}
variable "OS" {
  description = "El sistema operativo elegido es"
  default     = "OL7"
}
# VNIC INFO
variable "private_ip" {
  default = "192.168.10.51"
}

# BOOT INFO
# user data
variable "user_data" {
  default = "~/Oravm2/azure/user_data_azure.txt"
}

# EBS
#
variable "network_interface" {
  description = "Personalizar interface en el arranque"
  type        = list(map(string))
  default     = []
}
