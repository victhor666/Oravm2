 
##############################
##### VARIABLES GENERALES
##############################

# Aws account region and autehntication 
#variable "aws_access_key" {}
#variable "aws_secret_key" {}
variable "Proyecto" {
    default = "Oracle"
}

variable "Location" {
    default = "eu-central-1"
}

##############################
#####VARIABLES NETWORK
##############################
# VPC 
    
    variable "vpc_cidr" {
      default = "192.168.0.0/16"
    }

# SUBNET 

    variable "subnet_cidr"{
      default = "192.168.10.0/24"
      } 
    variable "map_public_ip_on_launch" { 
      description = "Se le asigna una ip publica al desplegar o no. "
      default = true   
    }  



##############################
#####VARIABLES SERVER
##############################

      variable "preserve_boot_volume" {
        default = false
      }
      variable "boot_volume_size_in_gbs" {
        default = "30"
      }
      variable "instance_type" {
        default = "t2.micro"
      }
      variable "ami_id" {
        default   = "ami-0fe31afc27340dc76"
     }

# VNIC INFO
        variable "private_ip" {
        default = "192.168.10.51"
      }
      
# BOOT INFO      
  # user data
      variable "user_data_aws" {
        default = "~/Oravm2/aws/user_data_aws.txt"
      }     
      variable "block_storage_size_in_gbs" {
        default = "10"
      }
 # EBS 
      variable "vol_name" {
      type        = string
      default     = "vol_0"
      description = "The name of the EBS"
      }
      variable "ebs_volume_enabled" {
      type        = bool
      default     = true
      description = "Flag to control the ebs creation."
      }     
      variable "ebs_volume_type" {
      type        = string
      default     = "gp2"
      description = "The type of EBS volume. Can be standard, gp2 or io1."
      }
      variable "ebs_iops" {
      type        = number
      default     = 0
      description = "Amount of provisioned IOPS. This must be set with a volume_type of io1."
      }

      variable "ebs_volume_size" {
       type        = number
       default     = 8
       description = "Size of the ebs volume in gigabytes."
      }
      variable "ebs_device_name" {
      type        = list(string)
      default     = ["/dev/xvdb", "/dev/xvdc", "/dev/xvdd", "/dev/xvde", "/dev/xvdf", "/dev/xvdg", "/dev/xvdh", "/dev/xvdi", "/dev/xvdj", "/dev/xvdk", "/dev/xvdl", "/dev/xvdm", "/dev/xvdn", "/dev/xvdo", "/dev/xvdp", "/dev/xvdq", "/dev/xvdr", "/dev/xvds", "/dev/xvdt", "/dev/xvdu", "/dev/xvdv", "/dev/xvdw", "/dev/xvdx", "/dev/xvdy", "/dev/xvdz"]
      description = "Name of the EBS device to mount."
      }

      variable "instance_cpus" {
      default = 1
      }        