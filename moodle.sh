#!/bin/bash

#Colores de texto
Defecto='\e[39m'
Rojo='\e[31m'
Verde='\e[32m'
Azul='\e[36m'
subrayado='\e[4m' 

#Lista de todos los paquetes
echo "Esta apunto de instalar el servidor moodle y con ello todos los siguientes paquetes: "
echo -e "${Azul}1)apache2 2)mariadb-server 3)php 4)php-mysql 5)php-zip 6)php-curl 7)php-xml 8)php-mbstring"
echo -e "9)php-gd 10)php-soap 11)php-intl 12)software-properties-common 13)dirmngr${Defecto}"

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

#Instalación del paquete LAMP

#Instalación del Apache2
if [ $(dpkg-query -W -f='${Status}' 'apache2' >/dev/null 2>&1 | grep -c "ok installed") -eq 0 ]; then 
	echo -e "${Azul}Apache2${Defecto} no esta instalado"
	echo  "Apache2 no está instalado" >/script/registro.txt
	apt-get -y install apache2 >/dev/null 2>&1

	if [ $? -eq 0 ];then
		echo "Apache2 se ha instalado correctamente" >>/script/registro.txt
		echo -e "${Azul}Apache2${Defecto} ${Verde}se ha instalado correctamente${Defecto}"
	else
		echo "Apache2 no se ha instalado correctamente "  >>/script/registro.txt
		echo -e "${Azul}Apache2${Defecto} ${Rojo}no se ha instalado correctamente ${Defecto}" 
	fi
else
	echo "Apache2 ya está instalado" >>/script/registro.txt
	echo -e "${Azul}Apache2${Defecto} ya está instalado"
fi

#Instalación del paquete mariadb-server versión 10.4

#Instalación del software-propierties-common 
if [ $(dpkg-query -W -f='${Status}' 'software-properties-common' >/dev/null 2>&1 | grep -c "ok installed") -eq 0 ];then 
	echo -e "${Azul}software-properties-common${Defecto} no está instalado" 
	echo "software-properties-common no está instalado" >>/script/registro.txt

	apt-get -y install software-properties-common  >/dev/null 2>&1
	if [ $? -eq 0 ];then
		echo "software-properties-common se ha instalado correctamente" >>/script/registro.txt
		echo -e "${Azul}software-properties-common${Defecto} ${Verde}se ha instalado correctamente${Defecto}"
	else
		echo "software-properties-common no se ha instalado correctamente" >>/script/registro.txt
		echo -e "${Azul}software-properties-common${Defecto} ${Rojo}no se ha instalado correctamente${Defecto}"
	fi
else
	echo "software-properties-common está instalado" >>/script/registro.txt
	echo -e "${Azul}software-properties-common${Defecto} está instalado" 
fi

#Instalación del dirmngr
if [ $(dpkg-query -W -f='${Status}' 'dirmngr' >/dev/null 2>&1 | grep -c "ok installed") -eq 0 ];then 
	echo -e "${Azul}dirmngr${Defecto} no está instalado" 
	echo "dirmngr no está instalado" >>/script/registro.txt

	apt-get -y install dirmngr >/dev/null 2>&1
	if [ $? -eq 0 ];then
		echo "dirmngr se ha instalado correctamente" >>/script/registro.txt
		echo -e "${Azul}dirmngr${Defecto} ${Verde}se ha instalado correctamente${Defecto}"
	else
		echo "dirmngr no se ha instalado correctamente" >>/script/registro.txt
		echo -e "${Azul}dirmngr${Defecto} ${Rojo}no se ha instalado correctamente${Defecto}"
	fi
else
	echo "dirmngr está instalado" >>/script/registro.txt
	echo -e "${Azul}dirmngr${Defecto} está instalado" 
fi

#Inserción de la clave
apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xF1656F24C74CD1D8 >/dev/null 2>&1

if [ $? -eq 0 ];then
	echo -e "${Verde}La clave se colocó correctamente${Defecto}"
	echo "La clave se colocó correctamente" >>/script/registro.txt
else
	echo -e "${Rojo}Error en la clave${Defecto}"
	echo "Error en la clave" >>/script/registro.txt
fi

#Repositorio del mariadb
add-apt-repository 'deb [arch=amd64] http://mirror.rackspace.com/mariadb/repo/10.4/debian buster main' >/dev/null 2>&1

if [ $? -eq 0 ];then
	echo -e "${Verde}El repositorio se colocó correctamente${Defecto}"
	echo "El repositorio se colocó correctamente" >>/script/registro.txt
else
	echo -e "${Rojo}El repositorio no se coloco correctamente${Defecto}"
	echo "El repositorio no se coloco correctamente" >>/script/registro.txt
fi

#Actualización de los paquetes
apt-get update >/dev/null 2>&1


#Instalación del mariadb-server 
if [ $(dpkg-query -W -f='${Status}' 'mariadb-server-10.4' >/dev/null 2>&1 | grep -c "ok installed") -eq 0 ];then 
	echo -e "${Azul}Mariadb-server${Defecto} no está instalado" 
	echo "Mariadb-server no está instalado" >>/script/registro.txt

	apt-get update >/dev/null 2>&1
	apt-get -y install mariadb-server >/dev/null 2>&1

	if [ $? -eq 0 ];then
		echo "Mariadb-server se ha instalado correctamente" >>/script/registro.txt
		echo -e "${Azul}Mariadb-server${Defecto} ${Verde}se ha instalado correctamente${Defecto}"
	else
		echo "Mariadb-server no se ha instalado correctamente" >>/script/registro.txt
		echo -e "${Azul}Mariadb-server${Defecto} ${Rojo}no se ha instalado correctamente${Defecto}"
	fi
else
	echo "Mariadb-server está instalado" >>/script/registro.txt
	echo -e "${Azul}Mariadb-server${Defecto} está instalado" 
fi

#Instalación del paquete php 7.4
if [ $(dpkg-query -W -f='${Status}' 'php7.4' >/dev/null 2>&1 | grep -c "ok installed") -eq 0 ];then 
	echo "Php no está instalado" >>/script/registro.txt
	echo -e "${Azul}Php${Defecto} no está instalado"

	apt -y install lsb-release apt-transport-https ca-certificates >/dev/null 2>&1
	wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg >/dev/null 2>&1
	echo "deb https://packages.sury.org/php/ $( lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list >/dev/null 2>&1
	apt-get update >/dev/null 2>&1
	apt-get -y install php7.4 >/dev/null 2>&1
	if [ $? -eq 0 ];then
		echo -e "${Azul}php 7.4${Defecto} ${Verde}se ha instalado correctamente${Defecto}"
		echo "php 7.4 se ha instalado correctamente" >>/script/registro.txt
	else
		echo -e "${Azul}php 7.4${Defecto} ${Rojo}no se ha instalado correctamente${Defecto}"
		echo "php 7.4 no se ha instalado correctamente" >>/script/registro.txt
	fi
else
	echo -e "${Azul}Php${Defecto} ya está instalado"
	echo "Php ya está instalado" >>/script/registro.txt
fi

# Instalación de las expansiones de php

# Instalación de php-mysql
if [ $(dpkg-query -W -f='${Status}' 'php7.4-mysql' >/dev/null 2>&1 | grep -c "ok installed") -eq 0 ];then 
	
	echo -e "${Azul}php-mysql${Defecto} no está instalado" 
	echo "php-mysql no está instalado" >>/script/registro.txt
	apt-get update >/dev/null 2>&1
	apt-get -y install php7.4-mysql  >/dev/null 2>&1

	if [ $? -eq 0 ];then

		echo "php-mysql se ha instalado correctamente" >>/script/registro.txt
		echo -e "${Azul}php-mysql${Defecto} ${Verde}se ha instalado correctamente${Defecto}"
	else
		echo -e "${Azul}php-mysql${Defecto} ${Rojo}no se ha instalado correctamente${Defecto}"
		echo "php-mysql no se ha instalado correctamente" >>/script/registro.txt
	fi
else
	echo "php-mysql ya está instalado" >>/script/registro.txt
	echo -e "${Azul}php-mysql${Defecto} ya está instalado"
fi

# Instalación de php-xml
if [ $(dpkg-query -W -f='${Status}' 'php7.4-xml' >/dev/null 2>&1 | grep -c "ok installed") -eq 0 ];then 
	
	echo -e "${Azul}php-xml${Defecto} no está instalado" 
	echo "php-xml no está instalado" >>/script/registro.txt
	apt-get update >/dev/null 2>&1
	apt-get -y install php7.4-xml  >/dev/null 2>&1

	if [ $? -eq 0 ];then

		echo "php-xml se ha instalado correctamente" >>/script/registro.txt
		echo -e "${Azul}php-xml${Defecto} ${Verde}se ha instalado correctamente${Defecto}"
	else
		echo -e "${Azul}php-xml${Defecto} ${Rojo}no se ha instalado correctamente${Defecto}"
		echo "php-xml no se ha instalado correctamente" >>/script/registro.txt
	fi
else
	echo "php-xml ya está instalado" >>/script/registro.txt
	echo -e "${Azul}php-xml${Defecto} ya está instalado"
fi

# Instalación de php-mbstring
if [ $(dpkg-query -W -f='${Status}' 'php7.4-mbstring' >/dev/null 2>&1 | grep -c "ok installed") -eq 0 ];then 
	
	echo -e "${Azul}php-mbstring${Defecto} no está instalado"
	echo "php-mbstring no está instalado" >>/script/registro.txt
	apt-get -y install php7.4-mbstring >/dev/null 2>&1

	if [ $? -eq 0 ];then
		echo "php-mbstring se ha instalado correctamente" >>/script/registro.txt
		echo -e "${Azul}php-mbstring${Defecto} ${Verde}se ha instalado correctamente${Defecto}"

	else
		echo -e "${Azul}php-mbstring${Defecto} ${Rojo}no se ha instalado correctamente${Defecto}"
		echo "php-mbstring no se ha instalado correctamente" >>/script/registro.txt
	fi
else
	echo "php-mbstring ya está instalado" >>/script/registro.txt
	echo -e "${Azul}php-mbstring${Defecto} ya está instalado"
fi

# Instalación de php-curl
if [ $(dpkg-query -W -f='${Status}' 'php7.4-curl' >/dev/null 2>&1 | grep -c "ok installed") -eq 0 ];then 

	echo -e "${Azul}php-curl${Defecto} no está instalado"
	echo "php-curl no está instalado" >>/script/registro.txt
	apt-get -y install php7.4-curl >/dev/null 2>&1

	if [ $? -eq 0 ];then
		echo "php-curl se ha instalado correctamente" >>/script/registro.txt
		echo -e "${Azul}php-curl${Defecto} ${Verde}se ha instalado correctamente${Defecto}"
	else
		echo -e "${Azul}php-curl${Defecto} ${Rojo}no se ha instalado correctamente${Defecto}"
		echo "php-curl no se ha instalado correctamente" >>/script/registro.txt
	fi
else
	echo "php-curl ya está instalado" >>/script/registro.txt
	echo -e "${Azul}php-curl${Defecto} ya está instalado"
fi

# Instalación de php-zip
if [ $(dpkg-query -W -f='${Status}' 'php7.4-zip' >/dev/null 2>&1 | grep -c "ok installed") -eq 0 ];then

	echo -e "${Azul}php-zip${Defecto} no está instalado"
	echo "php-zip no está instalado" >>/script/registro.txt
	apt-get -y install php7.4-zip >/dev/null 2>&1

	if [ $? -eq 0 ];then
		echo -e "php-zip se ha instalado correctamente" >>/script/registro.txt
		echo -e "${Azul}php-zip${Defecto} ${Verde}se ha instalado correctamente${Defecto}"
	else
		echo -e "${Azul}php-zip${Defecto} ${Rojo}no se ha instalado correctamente${Defecto}"
		echo "php-zip no se ha instalado correctamente" >>/script/registro.txt
	fi
else
	echo "php-zip ya está instalado" >>/script/registro.txt
	echo -e "${Azul}php-zip${Defecto} ya está instalado"
fi

# Instalación de php-gd
if [ $(dpkg-query -W -f='${Status}' 'php7.4-gd' >/dev/null 2>&1 | grep -c "ok installed") -eq 0 ];then

	echo -e "${Azul}php-gd${Defecto} no está instalado"
	echo "php-gd no está instalado" >>/script/registro.txt
	apt-get -y install php7.4-gd >/dev/null 2>&1

	if [ $? -eq 0 ];then
		echo -e "php-gd se ha instalado correctamente" >>/script/registro.txt
		echo -e "${Azul}php-gd${Defecto} ${Verde}se ha instalado correctamente${Defecto}"

	else
		echo -e "${Azul}php-gd${Defecto} ${Rojo}no se ha instalado correctamente${Defecto}"
		echo "php-gd no se ha instalado correctamente" >>/script/registro.txt
	fi
else
	echo "php-gd ya está instalado" >>/script/registro.txt
	echo -e "${Azul}php-gd${Defecto} ya está instalado"
fi

# Instalación de php-intl
if [ $(dpkg-query -W -f='${Status}' 'php7.4-intl' >/dev/null 2>&1 | grep -c "ok installed") -eq 0 ];then

	echo -e "${Azul}php-intl${Defecto} no está instalado"
	echo "php-intl no está instalado" >>/script/registro.txt
	apt-get -y install php7.4-intl >/dev/null 2>&1

	if [ $? -eq 0 ];then
		echo "php-intl se ha instalado correctamente" >>/script/registro.txt
		echo -e "${Azul}php-intl${Defecto} ${Verde}se ha instalado correctamente${Defecto}"
	else
		echo -e "${Azul}php-intl${Defecto} ${Rojo}no se ha instalado correctamente${Defecto}"
		echo "php-intl no se ha instalado correctamente" >>/script/registro.txt
	fi
else
	echo "php-intl ya está instalado" >>/script/registro.txt
	echo -e "${Azul}php-intl${Defecto} ya está instalado"
fi

# Instalación de php-soap
if [ $(dpkg-query -W -f='${Status}' 'php7.4-soap' >/dev/null 2>&1 | grep -c "ok installed") -eq 0 ];then

	echo -e "${Azul}php-soap${Defecto} no está instalado"
	echo "php-soap no está instalado" >>/script/registro.txt
	apt-get -y install php7.4-soap >/dev/null 2>&1

	if [ $? -eq 0 ];then
		echo "php-soap se ha instalado correctamente" >>/script/registro.txt
		echo -e "${Azul}php-soap${Defecto} ${Verde}se ha instalado correctamente${Defecto}"
	else
		echo -e "${Azul}php-soap${Defecto} ${Rojo}no se ha instalado correctamente${Defecto}"
		echo "php-soap no se ha instalado correctamente" >>/script/registro.txt
	fi
else
	echo "php-soap ya está instalado" >>/script/registro.txt
	echo -e "${Azul}php-soap${Defecto} ya está instalado"
fi

#Creación de la base de datos para el servidor y Comprobación de que la base de datos ha sido creada

dbname="moodle"
if [ -d "/var/lib/mysql/$dbname" ]; then
	echo "La base de datos moodle ya existe"
	echo "La base de datos moodle ya existe" >>/script/registro.txt
else 	
	echo "La base de datos moodle no existe"
	echo "Iniciando la creación de la base de datos moodle"
	echo "La base de datos moodle no existe" >>/script/registro.txt
	echo "Iniciando la creación de la base de datos moodle" >>/script/registro.txt

	mysql -u root -e "CREATE DATABASE moodle;"
	mysql -u root -e "CREATE USER 'moodle'@'localhost' IDENTIFIED by 'moodle';"
	mysql -u root -e "GRANT ALL PRIVILEGES ON moodle.* TO 'moodle'@'localhost';"
	mysql -u root -e "FLUSH PRIVILEGES;"
	mysql -u root -e "exit"
	
	echo "Creación exitosa" >>/script/registro.txt
	echo -e "${Verde}Creación exitosa${Defecto}"  
fi


#Redirrecion al directorio opt
cd /opt/ >/dev/null 2>&1
if [ $? -eq 0 ]; then
	echo "Dirigirse al directorio opt" 
	echo "Dirigirse al directorio opt" >>/script/registro.txt
else
	echo -e "${Rojo}Error al dirigirse al directorio opt${Defecto}"
	echo "Error al dirigirse al directorio opt" >>/script/registro.txt
fi

#Descarga del servidor moodle
wget https://download.moodle.org/download.php/direct/stable401/moodle-latest-401.tgz >/dev/null 2>&1
if [ $? -eq 0 ]; then
	echo -e "${Verde}Descarga exitosa del archivo moodle${Defecto}"
	echo "Descarga exitosa del archivo moodle" >>/script/registro.txt
else
	echo -e "${Rojo}Error al descargar el archivo moodle${Defecto}"
	echo "Error al descargar el archivo moodle" >>/script/registro.txt
fi

#Descomprimir el archivo moodle
tar zxvf moodle-latest-401.tgz >/dev/null 2>&1
if [ $? -eq 0 ]; then
	echo -e "${Verde}La extracción del archivo moodle fue exitosa${Defecto}"
	echo "La extracción del archivo moodle fue exitosa" >>/script/registro.txt
else
	echo -e "${Rojo}Error en la extracción del archivo moodle${Defecto}"
	echo "Error en la extracción del archivo moodle" >>/script/registro.txt
fi

#Eliminación del fichero index
rm /var/www/html/index.html >/dev/null 2>&1
if [ $? -eq 0 ];then
	echo -e "${Verde}La eliminación del fichero index fue exitosa${Defecto}"
	echo "La eliminación del fichero index fue exitosa" >>/script/registro.txt
else
	echo -e "${Rojo}Error en la eliminación del fichero${Defecto}"
	echo "Error en la eliminación del fichero" >>/script/registro.txt
fi

#Cambiar de directorio el archivo moodle
mv moodle/ /var/www/html/ >/dev/null 2>&1
if [ $? -eq 0 ]; then
	echo -e "${Verde}El cambio de directorio se realizó correctamente${Defecto}"
	echo "El cambio de directorio se realizó correctamente" >>/script/registro.txt
else
	echo -e "${Rojo}Error al cambiar de directorio${Defecto}"
	echo "Error al cambiar de directorio" >>/script/registro.txt
fi

#Crear el directorio necesario para el moodle 
mkdir /var/www/moodledata >/dev/null 2>&1
if [ $? -eq 0 ];then
	echo -e "${Verde}La carpeta moodledata se creo correctamente${Defecto}"
	echo "La carpeta moodledata se creo correctamente" >>/script/registro.txt
else
	echo -e "${Rojo}La carpeta no pudo crearse${Defecto}"
	echo "La carpeta no pudo crearse" >>/script/registro.txt
fi

#Añadir los permisos necesarios 
chmod -R 755 /var/www/ >/dev/null 2>&1
if [ $? -eq 0 ]; then
	echo -e "${Verde}Se añadieron los permisos necesarios correctamente${Defecto}"
	echo -e "${Verde}Se añadieron los permisos necesarios correctamente" >>/script/registro.txt
else
	echo -e "${Rojo}No se añadieron los permisos necesarios${Defecto}"
	echo "No se añadieron los permisos necesarios" >>/script/registro.txt
fi

#Cambio de propietario
chown -R www-data:www-data /var/www/ >/dev/null 2>&1
if [ $? -eq 0 ]; then
	echo -e "${Verde}El cambio de propietario se realizó correctamente${Defecto}"
	echo "El cambio de propietario se realizó correctamente" >>/script/registro.txt
else
	echo -e "${Rojo}Error al cambiar de propietario${Defecto}"
	echo "Error al cambiar de propietario" >>/script/registro.txt
fi

#actualización de los paquetes y reinicio del servidor apache
apt-get -y upgrade >/dev/null 2>&1
if [ $? -eq 0 ];then
	echo -e "${Verde}La actualización se realizó correctamente${Defecto}"
	echo "La actualización se realizó correctamente" >>/script/registro.txt
else
	echo -e "${Rojo}Error en la actualización${Defecto}"
	echo "Error en la actualización" >>/script/registro.txt
fi

systemctl restart apache2 >/dev/null 2>&1
if [ $? -eq 0 ];then
	echo -e "${Verde}Reinicio correcto${Defecto}"
	echo "Reinicio correcto" >>/script/registro.txt
else
	echo -e "${Rojo}Error al reiniciar el servidor${Defecto}"
	echo "Error al reiniciar el servidor" >>/script/registro.txt
fi

echo "FIN DE LA INSTALACIÓN"