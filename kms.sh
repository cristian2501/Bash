#!/bin/bash

#Colores de texto
Defecto='\e[39m'
Rojo='\e[31m'
Verde='\e[32m'
Celeste='\e[36m'
subrayado='\e[4m' 

#Confirmación de la instalación
echo "Estas seguro de proceder con la instalación (S/N): " 
read confirmacion
if [ "$confirmacion" = "S" ] || [ "$confirmacion" = "s" ];then
	echo "Procederemos con la instalación"
else
	echo "Instalación cancelada "
	exit
fi		

#Comprobación de usuario
if [ $(whoami) == "root" ]; then
	echo -e "Tienes los permisos"
else
	echo "Para instalar los paquetes necesarios has de tener permisos como root"
	exit
fi

#Actualización de paquetes

apt-get update >/dev/null 2>&1

#Instalación del servidor KMS

#Descarga del kms
wget https://github.com/SystemRage/py-kms/archive/refs/heads/master.zip
if [ $? -eq 0 ];then
		echo "Apache2 se ha instalado correctamente" >>/script/registro.txt
		echo -e "${Celeste}Apache2${Defecto} ${Verde}se ha instalado correctamente${Defecto}"
	else
		echo "Apache2 no se ha instalado correctamente "  >>/script/registro.txt
		echo -e "${Celeste}Apache2${Defecto} ${Rojo}no se ha instalado correctamente ${Defecto}" 
	fi

#Paquete necesario para la extracion de la carpeta KMS
if [ $(dpkg-query -W -f='${Status}' 'unzip' >/dev/null 2>&1 | grep -c "ok installed") -eq 0 ];then

	echo -e "${Celeste}unzip${Defecto} no está instalado"
	echo "unzip no está instalado" >>/script/registro.txt
	apt-get -y install unzip >/dev/null 2>&1

	if [ $? -eq 0 ];then
		echo "unzip se ha instalado correctamente" >>/script/registro.txt
		echo -e "${Celeste}unzip${Defecto} ${Verde}se ha instalado correctamente${Defecto}"
	else
		echo -e "${Celeste}unzip${Defecto} ${Rojo}no se ha instalado correctamente${Defecto}"
		echo "unzip no se ha instalado correctamente" >>/script/registro.txt
	fi
else
	echo "unzip ya está instalado" >>/script/registro.txt
	echo -e "${Celeste}unzip${Defecto} ya está instalado"
fi

#Creación de un directorio donde estara el kms 
