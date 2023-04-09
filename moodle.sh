#!/bin/bash
#Comprovem usuari

if [ $(whoami) == "root" ]; then
	echo -e "Eres root."
else
	echo "No eres root"
	echo "Para instalar los paquetes necesarios has de iniciar sesion como root."
	exit
fi

#Instalar el paquete LAMP

#Instal.lació paquet Apache2
if [ $(dpkg-query -W -f='${Status}' 'apache2' | grep -c "ok installed") -eq 0 ];then 

	echo "Apache2 no esta instalado" >/script/registro.txt

	apt-get -y install apache2 >/dev/null 2>&1

	if [ $? -eq 0 ];then

		echo "Apache2 se ha instalado correctamente." >>/script/registro.txt
		echo "Apache2 se ha instalado correctamente."

	else

		echo "Apache2 no se ha instalado correctamente." >>/script/registro.txt
		echo "Apache2 se ha instalado correctamente." 

	fi
else
	echo "Apache2 ya esta instalado"
fi

#Instal.lació paquet mariadb-server versión 10.4

if [ $(dpkg-query -W -f='${Status}' 'mariadb-server' | grep -c "ok installed") -eq 0 ];then 
	echo "Mariadv-server no esta instalado" 
	apt-get install software-propierties-common dirmngr
	apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xF1656F24C74CD1D8
	add-apt-repository ‘deb [arch=amd64]
	http://mirror.rackspace.com/mariadb/repo/10.4/debian buster main’
	apt-get update
	apt-get install mariadb-server
	
	if [ $? -eq 0 ];then
		echo "Mariadb-server se ha instalado correctamente." >>/script/registro.txt
		echo "Mariadb-server se ha instalado correctamente."
	else
		echo "Mariadb-server no se ha instalado correctamente." >>/script/registro.txt
		echo "Mariadb-server no se ha instalado correctamente."
	fi
else
	echo "Mariadb-server està instal.lat"
fi

#Instal.lació paquet php 7.4
if [ $(dpkg-query -W -f='${Status}' 'php' | grep -c "ok installed") -eq 0 ];then 
	echo “PHP no está instalado”
	apt -y install lsb-release apt-transport-https ca-certificates
	wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
	echo “deb https://packages.sury.org/php/ $( lsb_release -sc) main” | tee
      /etc/apt/sources.list.d/php.list
	apt-get update
	apt-get install php7.4
	if [ $? -eq 0 ];then
		echo "PHP 7.4 se ha instalado correctamente"
		echo "PHP 7.4 se ha instalado correctamente">/script/registro.txt
	else
		echo "php 7.4 no se ha instalado correctamente"
		echo "php 7.4 no se ha instalado correctamente">>/script/registro.txt
fi 

# Instalación de las expansiones de php

# Instalación de php-xml
if [ $(dpkg-query -W -f='${Status}' 'php7.4-xml' | grep -c "ok installed") -eq 0 ];then 

	echo "php-xml no esta instalado" >/script/registro.txt

	apt-get install php 7.4-xml  >/dev/null 2>&1

	if [ $? -eq 0 ];then

		echo "php-xml se ha instalado correctamente" >>/script/registro.txt
		echo "php-xml se ha instalado correctamente"

	else

		echo "php-xml no se ha instalado correctamente"
		echo "php-xml no se ha instalado correctamente" >>/script/registro.txt

	fi
else
	echo "php-xml ya esta instalado" >>/script/registro.txt
	echo "php-xml ya esta instalado"
fi

# Instalación de php-mbstring
if [ $(dpkg-query -W -f='${Status}' 'php7.4-mbstring' | grep -c "ok installed") -eq 0 ];then 

	echo "php-mbstring no esta instalado" >/script/registro.txt

	apt-get install php7.4-mbstring >/dev/null 2>&1

	if [ $? -eq 0 ];then

		echo "php-mbstring se ha instalado correctamente" >>/script/registro.txt
		echo "php-mbstring se ha instalado correctamente"

	else

		echo "php-mbstring no se ha instalado correctamente"
		echo "php-mbstring no se ha instalado correctamente" >>/script/registro.txt

	fi
else
	echo "php-mbstring ya esta instalado" >>/script/registro.txt
	echo "php-mbstring ya esta instalado"
fi

# Instalación de php-curl
if [ $(dpkg-query -W -f='${Status}' 'php7.4-curl' | grep -c "ok installed") -eq 0 ];then 

	echo "php-curl no esta instalado" >/script/registro.txt

	apt-get install php7.4-curl >/dev/null 2>&1

	if [ $? -eq 0 ];then

		echo "php-curl se ha instalado correctamente" >>/script/registro.txt
		echo "php-curl se ha instalado correctamente"

	else

		echo "php-curl no se ha instalado correctamente"
		echo "php-curl no se ha instalado correctamente" >>/script/registro.txt

	fi
else
	echo "php-curl ya esta instalado" >>/script/registro.txt
	echo "php-curl ya esta instalado"
fi

# Instalación de php-zip
if [ $(dpkg-query -W -f='${Status}' 'php7.4-zip' | grep -c "ok installed") -eq 0 ];then 

	echo "php-zip no esta instalado" >/script/registro.txt

	apt-get install php7.4-zip >/dev/null 2>&1

	if [ $? -eq 0 ];then

		echo "php-zip se ha instalado correctamente" >>/script/registro.txt
		echo "php-zip se ha instalado correctamente"

	else

		echo "php-zip no se ha instalado correctamente"
		echo "php-zip no se ha instalado correctamente" >>/script/registro.txt

	fi
else
	echo "php-zip ya esta instalado" >>/script/registro.txt
	echo "php-zip ya esta instalado"
fi

# Instalación de php-gd
if [ $(dpkg-query -W -f='${Status}' 'php7.4-gd' | grep -c "ok installed") -eq 0 ];then 

	echo "php-zip no esta instalado" >/script/registro.txt

	apt-get install php7.4-gd >/dev/null 2>&1

	if [ $? -eq 0 ];then

		echo "php-gd se ha instalado correctamente" >>/script/registro.txt
		echo "php-gd se ha instalado correctamente"

	else

		echo "php-gd no se ha instalado correctamente"
		echo "php-gd no se ha instalado correctamente" >>/script/registro.txt

	fi
else
	echo "php-gd ya esta instalado" >>/script/registro.txt
	echo "php-gd ya esta instalado"
fi

# Instalación de php-intl
if [ $(dpkg-query -W -f='${Status}' 'php7.4-intl' | grep -c "ok installed") -eq 0 ];then 

	echo "php-zip no esta instalado" >/script/registro.txt

	apt-get install php7.4-intl >/dev/null 2>&1

	if [ $? -eq 0 ];then

		echo "php-intl se ha instalado correctamente" >>/script/registro.txt
		echo "php-intl se ha instalado correctamente"

	else

		echo "php-intl no se ha instalado correctamente"
		echo "php-intl no se ha instalado correctamente" >>/script/registro.txt

	fi
else
	echo "php-intl ya esta instalado" >>/script/registro.txt
	echo "php-intl ya esta instalado"
fi

# Instalación de php-soap
if [ $(dpkg-query -W -f='${Status}' 'php7.4-soap' | grep -c "ok installed") -eq 0 ];then 

	echo "php-soap no esta instalado" >/script/registro.txt

	apt-get install php7.4-soap >/dev/null 2>&1

	if [ $? -eq 0 ];then

		echo "php-soap se ha instalado correctamente" >>/script/registro.txt
		echo "php-soap se ha instalado correctamente"

	else

		echo "php-soap no se ha instalado correctamente"
		echo "php-soap no se ha instalado correctamente" >>/script/registro.txt

	fi
else
	echo "php-soap ya esta instalado" >>/script/registro.txt
	echo "php-soap ya esta instalado"
fi

#Creación de la base de datos para el servidor 

#Comprobación de que la base de datos ha sido creada

dbname="moodle"
if [ -d "/var/lib/mysql/$dbname" ]; then   (-d = directorio)
	echo "La base de datos moodle existe" 
else 	
	echo "La base de datos moodle no existe"
	echo "Hacemos la instalación de la base de datos moodle"


mysql -u root -e "CREATE DATABASE moodle;"
mysql -u root -e "CREATE USER 'moodle'@'localhost' IDENTIFIED BY 'moodle';"
mysql -u root -e "GRANT ALL PRIVILEGES ON moodle.* TO 'moodle'@'localhost';
mysql -u root -e "FLUSH PRIVILEGES;"
mysql -u root -e "quit;"
	echo "Instalación hecha" 
fi


		
