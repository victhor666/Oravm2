output "vpc_Name" {
      description = "Nombre VPC. "
      value       = "${lookup(aws_vpc.Oracle-VPC.tags, "Name")}"
    }
output "vpc_id" {
      description = "ID VPC. "
      value       = aws_vpc.Oracle-VPC.id
    }
output "vpc_CIDR" {
      description = "cidr de la VPC. "
      value       = aws_vpc.Oracle-VPC.cidr_block
    }    
    
output "Subnet_Name" {
      description = "Nombre de la subred. "
      value       = "${lookup(aws_subnet.Oracle-SUBNET.tags, "Name")}"
    }
output "Subnet_id" {
      description = "ID de la subred. "
      value       = aws_subnet.Oracle-SUBNET.id
    }
output "Subnet_CIDR" {
      description = "CIDR de la subred. "
      value       = aws_subnet.Oracle-SUBNET.cidr_block
    }

output "map_public_ip_on_launch" {
      description = "La instancia tiene o no tiene ip publica asociada . "
      value       = aws_subnet.Oracle-SUBNET.map_public_ip_on_launch
    }
  
output "internet_gateway_id" {
       description = "id del internet gateway. "
       value       = aws_internet_gateway.Oracle-IGW.id
    }
output "internet_gateway_Name" {
       description = "Nombre del Internet Gateway. "
       value       = "${lookup(aws_internet_gateway.Oracle-IGW.tags, "Name")}"
    }    

output "route_table_id" {
       description = "id de la tabla de rutas. "
       value       = aws_route_table.Oracle-ROUTETABLE.id
    }
output "route_table_Name" {
       description = "Nombre de la tabla de rutas. "
       value       = "${lookup(aws_route_table.Oracle-ROUTETABLE.tags, "Name")}"
    }    
 
output "route_table_routes" {
       description = "Lista de rutas (solo debemos tener una). "
       value       = aws_route_table.Oracle-ROUTETABLE.route
    } 

output "vpc_dedicated_security_group_Name" {
       description = "Nombre del grupo de seguridad. "
       value       = aws_security_group.Oracle-SG.name
   }
output "vpc_dedicated_security_group_id" {
       description = "Id del grupo de seguridad "
       value       = aws_security_group.Oracle-SG.id
   }
output "SecurityGroup_ingress_rules" {
       description = "Reglas de entrada en el security group "
       value       = formatlist("%s:  %s" ,aws_security_group.Oracle-SG.ingress[*].description,formatlist("%s , CIDR: %s", aws_security_group.Oracle-SG.ingress[*].to_port,aws_security_group.Oracle-SG.ingress[*].cidr_blocks[0]))
       #value       = formatlist("%s:   %s" ,aws_security_group.terra_sg.ingress[*].description,aws_security_group.terra_sg.ingress[*].to_port)
   }      
    