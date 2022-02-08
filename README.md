# Oravm2
Despliegue de maquina oracle utilizando modulos
# Creamos la cuenta ssh 
ssh-keygen -P "" -C "Usuario para Maquina Oracle" -t rsa -b 2048 -m pem -f ~/Oravm/orauser


instalar aws cli 

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"