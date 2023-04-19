#!/bin/bash

#Colores de texto
Defecto='\e[39m'
Amarillo='\e[33m'
Lila='\e[35m'
Celeste='\e[36m'

#Comprobación de maquina
VERSIO=$(lsb_release -d | grep "Description" | cut -d ' ' -f2-4) 
DATA_IN=$(head -1 /var/log/installer/syslog | cut -c 1-12) 
DATA_FI=$(tail -1 /var/log/installer/syslog | cut -c 1-12) 
RAM=$(vmstat -s -S M | grep "total memory" | cut -c 1-16) 
HDD=$(df -h -t ext4 | awk ‘{pront $2}’ | sort -k 2 | head -1) 
echo "[*] Nom Alumne: ${nom}" 
echo "[*] La versió de Linux és: $VERSIO" 
echo "[*] Inici de la instal·lació: $DATA_IN"; 
echo "[*] Final de la instal·lació: $DATA_FI"; 
echo "[*] Característiques (RAM / HDD): $RAM / $HDD" 
echo 
echo "+---------------------------------------------+" 


#Lista de todos los paquetes
echo "Esta apunto de instalar el servidor glpi y con ello todos los siguientes paquetes: "
echo -e "${Lila}1)apache2 2)mariadb-server 3)php 4)php-mysql 5)php-zip 6)php-curl 7)php-xml 8)php-mbstring"
echo -e "9)php-gd 10)php-soap 11)php-intl 12)software-properties-common 13)dirmngr${Defecto}"

#Confirmación de la instalación
echo -e "${Lila}Estas seguro de proceder con la instalación (S/N): ${Defecto}" 
read confirmacion
if [ "$confirmacion" = "S" ] || [ "$confirmacion" = "s" ];then
	echo -e "${Lila}Procederemos con la instalación${Defecto}"
else
	echo "Instalación cancelada "
	exit
fi		

mkdir /var/logs/registres/install/
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
echo -e "${Lila}Instalando apache${Defecto}"
#Instalación del Apache2
if [ $(dpkg-query -W -f='${Status}' 'apache2' >/dev/null 2>&1 | grep -c "ok installed") -eq 0 ]; then 
	echo -e "${Azul}Apache2${Defecto} no esta instalado"
	echo  "Apache2 no está instalado" >/var/logs/registres/install/glpi.log
	apt-get -y install apache2 >/dev/null 2>&1

	if [ $? -eq 0 ];then
		echo "Apache2 se ha instalado correctamente" >>/var/logs/registres/install/glpi.log
		echo -e "${Azul}Apache2${Defecto} ${Celeste}se ha instalado correctamente${Defecto}"
	else
		echo "Apache2 no se ha instalado correctamente "  >>/var/logs/registres/install/errors.log
		echo -e "${Azul}Apache2${Defecto} ${Amarillo}no se ha instalado correctamente ${Defecto}" 
	fi
else
	echo "Apache2 ya está instalado" >>/var/logs/registres/install/glpi.log
	echo -e "${Azul}Apache2${Defecto} ya está instalado"
fi

#Instalación del paquete mariadb-server versión 10.4
echo -e "${Lila}Instalando mariadb-server en su ultima version${Defecto}"
#Instalación del software-propierties-common 
if [ $(dpkg-query -W -f='${Status}' 'software-properties-common' >/dev/null 2>&1 | grep -c "ok installed") -eq 0 ];then 
	echo -e "${Azul}software-properties-common${Defecto} no está instalado" 
	echo "software-properties-common no está instalado" >>/var/logs/registres/install/glpi.log

	apt-get -y install software-properties-common  >/dev/null 2>&1
	if [ $? -eq 0 ];then
		echo "software-properties-common se ha instalado correctamente" >>/var/logs/registres/install/glpi.log
		echo -e "${Azul}software-properties-common${Defecto} ${Celeste}se ha instalado correctamente${Defecto}"
	else
		echo "software-properties-common no se ha instalado correctamente" >>/var/logs/registres/install/errors.log
		echo -e "${Azul}software-properties-common${Defecto} ${Amarillo}no se ha instalado correctamente${Defecto}"
	fi
else
	echo "software-properties-common está instalado" >>/var/logs/registres/install/glpi.log
	echo -e "${Azul}software-properties-common${Defecto} está instalado" 
fi

#Instalación del dirmngr
if [ $(dpkg-query -W -f='${Status}' 'dirmngr' >/dev/null 2>&1 | grep -c "ok installed") -eq 0 ];then 
	echo -e "${Azul}dirmngr${Defecto} no está instalado" 
	echo "dirmngr no está instalado" >>/var/logs/registres/install/glpi.log

	apt-get -y install dirmngr >/dev/null 2>&1
	if [ $? -eq 0 ];then
		echo "dirmngr se ha instalado correctamente" >>/var/logs/registres/install/glpi.log
		echo -e "${Azul}dirmngr${Defecto} ${Celeste}se ha instalado correctamente${Defecto}"
	else
		echo "dirmngr no se ha instalado correctamente" >>/var/logs/registres/install/errors.log
		echo -e "${Azul}dirmngr${Defecto} ${Amarillo}no se ha instalado correctamente${Defecto}"
	fi
else
	echo "dirmngr está instalado" >>/var/logs/registres/install/glpi.log
	echo -e "${Azul}dirmngr${Defecto} está instalado" 
fi

#Inserción de la clave
apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xF1656F24C74CD1D8 >/dev/null 2>&1

if [ $? -eq 0 ];then
	echo -e "${Celeste}La clave se colocó correctamente${Defecto}"
	echo "La clave se colocó correctamente" >>/var/logs/registres/install/glpi.log
else
	echo -e "${Amarillo}Error en la clave${Defecto}"
	echo "Error en la clave" >>/var/logs/registres/install/glpi.log
fi

#Repositorio del mariadb
add-apt-repository 'deb [arch=amd64] http://mirror.rackspace.com/mariadb/repo/10.4/debian buster main' >/dev/null 2>&1

if [ $? -eq 0 ];then
	echo -e "${Celeste}El repositorio se colocó correctamente${Defecto}"
	echo "El repositorio se colocó correctamente" >>/var/logs/registres/install/glpi.log
else
	echo -e "${Amarillo}El repositorio no se coloco correctamente${Defecto}"
	echo "El repositorio no se coloco correctamente" >>/var/logs/registres/install/glpi.log
fi

#Actualización de los paquetes
apt-get update >/dev/null 2>&1


#Instalación del mariadb-server 
if [ $(dpkg-query -W -f='${Status}' 'mariadb-server-10.4' >/dev/null 2>&1 | grep -c "ok installed") -eq 0 ];then 
	echo -e "${Azul}Mariadb-server${Defecto} no está instalado" 
	echo "Mariadb-server no está instalado" >>/var/logs/registres/install/glpi.log

	apt-get update >/dev/null 2>&1
	apt-get -y install mariadb-server >/dev/null 2>&1

	if [ $? -eq 0 ];then
		echo "Mariadb-server se ha instalado correctamente" >>/var/logs/registres/install/glpi.log
		echo -e "${Azul}Mariadb-server${Defecto} ${Celeste}se ha instalado correctamente${Defecto}"
	else
		echo "Mariadb-server no se ha instalado correctamente" >>/var/logs/registres/install/errors.log
		echo -e "${Azul}Mariadb-server${Defecto} ${Amarillo}no se ha instalado correctamente${Defecto}"
	fi
else
	echo "Mariadb-server está instalado" >>/var/logs/registres/install/glpi.log
	echo -e "${Azul}Mariadb-server${Defecto} está instalado" 
fi

echo -e "${Lila}Instalando php en su ultima version${Defecto}"
#Instalación del paquete php 7.4
if [ $(dpkg-query -W -f='${Status}' 'php7.4' >/dev/null 2>&1 | grep -c "ok installed") -eq 0 ];then 
	echo "Php no está instalado" >>/var/logs/registres/install/glpi.log
	echo -e "${Azul}Php${Defecto} no está instalado"

	apt -y install lsb-release apt-transport-https ca-certificates >/dev/null 2>&1
	wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg >/dev/null 2>&1
	echo "deb https://packages.sury.org/php/ $( lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list >/dev/null 2>&1
	apt-get update >/dev/null 2>&1
	apt-get -y install php7.4 >/dev/null 2>&1
	if [ $? -eq 0 ];then
		echo -e "${Azul}php 7.4${Defecto} ${Celeste}se ha instalado correctamente${Defecto}"
		echo "php 7.4 se ha instalado correctamente" >>/var/logs/registres/install/glpi.log
	else
		echo -e "${Azul}php 7.4${Defecto} ${Amarillo}no se ha instalado correctamente${Defecto}"
		echo "php 7.4 no se ha instalado correctamente" >>/var/logs/registres/install/errors.log
	fi
else
	echo -e "${Azul}Php${Defecto} ya está instalado"
	echo "Php ya está instalado" >>/var/logs/registres/install/glpi.log
fi

# Instalación de las expansiones de php

echo -e "${Lila}Instalando dependencias de php ${Defecto}"
# Instalación de php-mysql
if [ $(dpkg-query -W -f='${Status}' 'php7.4-mysql' >/dev/null 2>&1 | grep -c "ok installed") -eq 0 ];then 
	
	echo -e "${Azul}php-mysql${Defecto} no está instalado" 
	echo "php-mysql no está instalado" >>/var/logs/registres/install/glpi.log
	apt-get update >/dev/null 2>&1
	apt-get -y install php7.4-mysql  >/dev/null 2>&1

	if [ $? -eq 0 ];then

		echo "php-mysql se ha instalado correctamente" >>/var/logs/registres/install/glpi.log
		echo -e "${Azul}php-mysql${Defecto} ${Celeste}se ha instalado correctamente${Defecto}"
	else
		echo -e "${Azul}php-mysql${Defecto} ${Amarillo}no se ha instalado correctamente${Defecto}"
		echo "php-mysql no se ha instalado correctamente" >>/var/logs/registres/install/errors.log
	fi
else
	echo "php-mysql ya está instalado" >>/var/logs/registres/install/glpi.log
	echo -e "${Azul}php-mysql${Defecto} ya está instalado"
fi

# Instalación de php-xml
if [ $(dpkg-query -W -f='${Status}' 'php7.4-xml' >/dev/null 2>&1 | grep -c "ok installed") -eq 0 ];then 
	
	echo -e "${Azul}php-xml${Defecto} no está instalado" 
	echo "php-xml no está instalado" >>/var/logs/registres/install/glpi.log
	apt-get update >/dev/null 2>&1
	apt-get -y install php7.4-xml  >/dev/null 2>&1

	if [ $? -eq 0 ];then

		echo "php-xml se ha instalado correctamente" >>/var/logs/registres/install/glpi.log
		echo -e "${Azul}php-xml${Defecto} ${Celeste}se ha instalado correctamente${Defecto}"
	else
		echo -e "${Azul}php-xml${Defecto} ${Amarillo}no se ha instalado correctamente${Defecto}"
		echo "php-xml no se ha instalado correctamente" >>/var/logs/registres/install/errors.log
	fi
else
	echo "php-xml ya está instalado" >>/var/logs/registres/install/glpi.log
	echo -e "${Azul}php-xml${Defecto} ya está instalado"
fi

# Instalación de php-mbstring
if [ $(dpkg-query -W -f='${Status}' 'php7.4-mbstring' >/dev/null 2>&1 | grep -c "ok installed") -eq 0 ];then 
	
	echo -e "${Azul}php-mbstring${Defecto} no está instalado"
	echo "php-mbstring no está instalado" >>/var/logs/registres/install/glpi.log
	apt-get -y install php7.4-mbstring >/dev/null 2>&1

	if [ $? -eq 0 ];then
		echo "php-mbstring se ha instalado correctamente" >>/var/logs/registres/install/glpi.log
		echo -e "${Azul}php-mbstring${Defecto} ${Celeste}se ha instalado correctamente${Defecto}"

	else
		echo -e "${Azul}php-mbstring${Defecto} ${Amarillo}no se ha instalado correctamente${Defecto}"
		echo "php-mbstring no se ha instalado correctamente" >>/var/logs/registres/install/errors.log
	fi
else
	echo "php-mbstring ya está instalado" >>/var/logs/registres/install/glpi.log
	echo -e "${Azul}php-mbstring${Defecto} ya está instalado"
fi

# Instalación de php-curl
if [ $(dpkg-query -W -f='${Status}' 'php7.4-curl' >/dev/null 2>&1 | grep -c "ok installed") -eq 0 ];then 

	echo -e "${Azul}php-curl${Defecto} no está instalado"
	echo "php-curl no está instalado" >>/var/logs/registres/install/glpi.log
	apt-get -y install php7.4-curl >/dev/null 2>&1

	if [ $? -eq 0 ];then
		echo "php-curl se ha instalado correctamente" >>/var/logs/registres/install/glpi.log
		echo -e "${Azul}php-curl${Defecto} ${Celeste}se ha instalado correctamente${Defecto}"
	else
		echo -e "${Azul}php-curl${Defecto} ${Amarillo}no se ha instalado correctamente${Defecto}"
		echo "php-curl no se ha instalado correctamente" >>/var/logs/registres/install/errors.log
	fi
else
	echo "php-curl ya está instalado" >>/var/logs/registres/install/glpi.log
	echo -e "${Azul}php-curl${Defecto} ya está instalado"
fi

# Instalación de php-zip
if [ $(dpkg-query -W -f='${Status}' 'php7.4-zip' >/dev/null 2>&1 | grep -c "ok installed") -eq 0 ];then

	echo -e "${Azul}php-zip${Defecto} no está instalado"
	echo "php-zip no está instalado" >>/var/logs/registres/install/glpi.log
	apt-get -y install php7.4-zip >/dev/null 2>&1

	if [ $? -eq 0 ];then
		echo -e "php-zip se ha instalado correctamente" >>/var/logs/registres/install/glpi.log
		echo -e "${Azul}php-zip${Defecto} ${Celeste}se ha instalado correctamente${Defecto}"
	else
		echo -e "${Azul}php-zip${Defecto} ${Amarillo}no se ha instalado correctamente${Defecto}"
		echo "php-zip no se ha instalado correctamente" >>/var/logs/registres/install/errors.log
	fi
else
	echo "php-zip ya está instalado" >>/var/logs/registres/install/glpi.log
	echo -e "${Azul}php-zip${Defecto} ya está instalado"
fi

# Instalación de php-gd
if [ $(dpkg-query -W -f='${Status}' 'php7.4-gd' >/dev/null 2>&1 | grep -c "ok installed") -eq 0 ];then

	echo -e "${Azul}php-gd${Defecto} no está instalado"
	echo "php-gd no está instalado" >>/var/logs/registres/install/glpi.log
	apt-get -y install php7.4-gd >/dev/null 2>&1

	if [ $? -eq 0 ];then
		echo -e "php-gd se ha instalado correctamente" >>/var/logs/registres/install/glpi.log
		echo -e "${Azul}php-gd${Defecto} ${Celeste}se ha instalado correctamente${Defecto}"

	else
		echo -e "${Azul}php-gd${Defecto} ${Amarillo}no se ha instalado correctamente${Defecto}"
		echo "php-gd no se ha instalado correctamente" >>/var/logs/registres/install/errors.log
	fi
else
	echo "php-gd ya está instalado" >>/var/logs/registres/install/glpi.log
	echo -e "${Azul}php-gd${Defecto} ya está instalado"
fi

# Instalación de php-intl
if [ $(dpkg-query -W -f='${Status}' 'php7.4-intl' >/dev/null 2>&1 | grep -c "ok installed") -eq 0 ];then

	echo -e "${Azul}php-intl${Defecto} no está instalado"
	echo "php-intl no está instalado" >>/var/logs/registres/install/glpi.log
	apt-get -y install php7.4-intl >/dev/null 2>&1

	if [ $? -eq 0 ];then
		echo "php-intl se ha instalado correctamente" >>/var/logs/registres/install/glpi.log
		echo -e "${Azul}php-intl${Defecto} ${Celeste}se ha instalado correctamente${Defecto}"
	else
		echo -e "${Azul}php-intl${Defecto} ${Amarillo}no se ha instalado correctamente${Defecto}"
		echo "php-intl no se ha instalado correctamente" >>/var/logs/registres/install/errors.log
	fi
else
	echo "php-intl ya está instalado" >>/var/logs/registres/install/glpi.log
	echo -e "${Azul}php-intl${Defecto} ya está instalado"
fi

# Instalación de php-soap
if [ $(dpkg-query -W -f='${Status}' 'php7.4-soap' >/dev/null 2>&1 | grep -c "ok installed") -eq 0 ];then

	echo -e "${Azul}php-soap${Defecto} no está instalado"
	echo "php-soap no está instalado" >>/var/logs/registres/install/glpi.log
	apt-get -y install php7.4-soap >/dev/null 2>&1

	if [ $? -eq 0 ];then
		echo "php-soap se ha instalado correctamente" >>/var/logs/registres/install/glpi.log
		echo -e "${Azul}php-soap${Defecto} ${Celeste}se ha instalado correctamente${Defecto}"
	else
		echo -e "${Azul}php-soap${Defecto} ${Amarillo}no se ha instalado correctamente${Defecto}"
		echo "php-soap no se ha instalado correctamente" >>/var/logs/registres/install/errors.log
	fi
else
	echo "php-soap ya está instalado" >>/var/logs/registres/install/glpi.log
	echo -e "${Azul}php-soap${Defecto} ya está instalado"
fi

#Creación de la base de datos para el servidor y Comprobación de que la base de datos ha sido creada
echo -e "${Lila}Crear la base de datos${Defecto}"

dbname="glpi"
if [ -d "/var/lib/mysql/$dbname" ]; then
	echo "La base de datos glpi ya existe"
	echo "La base de datos glpi ya existe" >>/var/logs/registres/install/glpi.log
else 	
	echo -e "${Lila}La base de datos glpi no existe${Defecto}"
	echo -e "${Lila}Iniciando la creación de la base de datos glpi${Defecto}"
	echo "La base de datos glpi no existe" >>/var/logs/registres/install/glpi.log
	echo "Iniciando la creación de la base de datos glpi" >>/var/logs/registres/install/glpi.log

	mysql -u root -e "CREATE DATABASE glpi;"
	mysql -u root -e "CREATE USER 'glpi'@'localhost' IDENTIFIED by 'glpi';"
	mysql -u root -e "GRANT ALL PRIVILEGES ON glpi.* TO 'glpi'@'localhost';"
	mysql -u root -e "FLUSH PRIVILEGES;"
	mysql -u root -e "exit"
	
	echo "Creación exitosa" >>/var/logs/registres/install/glpi.log
	echo -e "${Celeste}Creación exitosa${Defecto}"  
fi


#Redirrecion al directorio opt
cd /opt/ >/dev/null 2>&1
if [ $? -eq 0 ]; then
	echo -e "${Lila}Dirigirse al directorio opt${Defecto}" 
	echo "Dirigirse al directorio opt" >>/var/logs/registres/install/glpi.log
else
	echo -e "${Amarillo}Error al dirigirse al directorio opt${Defecto}"
	echo "Error al dirigirse al directorio opt" >>/var/logs/registres/install/glpi.log
fi

#Descarga del servidor glpi
wget https://github.com/glpi-project/glpi/releases/download/10.0.7/glpi-10.0.7.tgz >/dev/null 2>&1
if [ $? -eq 0 ]; then
	echo -e "${Celeste}Descarga exitosa del archivo glpi${Defecto}"
	echo "Descarga exitosa del archivo glpi" >>/var/logs/registres/install/glpi.log
else
	echo -e "${Amarillo}Error al descargar el archivo glpi${Defecto}"
	echo "Error al descargar el archivo glpi" >>/var/logs/registres/install/glpi.log
fi

#Descomprimir el archivo glpi
tar zxvf glpi-10.0.7.tgz >/dev/null 2>&1
if [ $? -eq 0 ]; then
	echo -e "${Celeste}La extracción del archivo glpi fue exitosa${Defecto}"
	echo "La extracción del archivo glpi fue exitosa" >>/var/logs/registres/install/glpi.log
else
	echo -e "${Amarillo}Error en la extracción del archivo glpi${Defecto}"
	echo "Error en la extracción del archivo glpi" >>/var/logs/registres/install/glpi.log
fi

#Eliminación del fichero index
rm /var/www/html/index.html >/dev/null 2>&1
if [ $? -eq 0 ];then
	echo -e "${Celeste}La eliminación del fichero index fue exitosa${Defecto}"
	echo "La eliminación del fichero index fue exitosa" >>/var/logs/registres/install/glpi.log
else
	echo -e "${Amarillo}Error en la eliminación del fichero${Defecto}"
	echo "Error en la eliminación del fichero" >>/var/logs/registres/install/glpi.log
fi

#Cambiar de directorio el archivo glpi
mv glpi/ /var/www/html/ >/dev/null 2>&1
if [ $? -eq 0 ]; then
	echo -e "${Celeste}El cambio de directorio se realizó correctamente${Defecto}"
	echo "El cambio de directorio se realizó correctamente" >>/var/logs/registres/install/glpi.log
else
	echo -e "${Amarillo}Error al cambiar de directorio${Defecto}"
	echo "Error al cambiar de directorio" >>/var/logs/registres/install/glpi.log
fi

#Añadir los permisos necesarios 
chmod -R 755 /var/www/ >/dev/null 2>&1
if [ $? -eq 0 ]; then
	echo -e "${Celeste}Se añadieron los permisos necesarios correctamente${Defecto}"
	echo -e "${Celeste}Se añadieron los permisos necesarios correctamente" >>/var/logs/registres/install/glpi.log
else
	echo -e "${Amarillo}No se añadieron los permisos necesarios${Defecto}"
	echo "No se añadieron los permisos necesarios" >>/var/logs/registres/install/glpi.log
fi

#Cambio de propietario
chown -R www-data:www-data /var/www/ >/dev/null 2>&1
if [ $? -eq 0 ]; then
	echo -e "${Celeste}El cambio de propietario se realizó correctamente${Defecto}"
	echo "El cambio de propietario se realizó correctamente" >>/var/logs/registres/install/glpi.log
else
	echo -e "${Amarillo}Error al cambiar de propietario${Defecto}"
	echo "Error al cambiar de propietario" >>/var/logs/registres/install/glpi.log
fi

#actualización de los paquetes y reinicio del servidor apache
apt-get -y upgrade >/dev/null 2>&1
if [ $? -eq 0 ];then
	echo -e "${Celeste}La actualización se realizó correctamente${Defecto}"
	echo "La actualización se realizó correctamente" >>/var/logs/registres/install/glpi.log
else
	echo -e "${Amarillo}Error en la actualización${Defecto}"
	echo "Error en la actualización" >>/var/logs/registres/install/glpi.log
fi

systemctl restart apache2 >/dev/null 2>&1
if [ $? -eq 0 ];then
	echo -e "${Celeste}Reinicio correcto${Defecto}"
	echo "Reinicio correcto" >>/var/logs/registres/install/glpi.log
else
	echo -e "${Amarillo}Error al reiniciar el servidor${Defecto}"
	echo "Error al reiniciar el servidor" >>/var/logs/registres/install/glpi.log
fi

echo "FIN DE LA INSTALACIÓN"
