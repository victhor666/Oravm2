# Oravm2
Despliegue de maquina oracle utilizando modulos
# Creamos la cuenta ssh 
ssh-keygen -P "" -C "Usuario para Maquina Oracle" -t rsa -b 2048 -m pem -f ~/Oravm2/orauser


instalar aws cli 

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
luego tenemos que crear el fichero de credenciales con 

#aws configure 

ahi ponemos las claves y como region, por ejemplo eu-central-1 (Mónaco di Baviera)

luego ya deberíamos poder desplegar tanto en aws como en azurre. 
NOTA: Como el software lo descarga desde azure (además un bucket que está en usa) tarda bastante, puede que una hora. Solución simple si se va a desplegar mucho en aws...copiar esos ficheros en un bucket de aws en alemania, y cambiar las referencias en el fichero de despliegue user_data_aws.txt