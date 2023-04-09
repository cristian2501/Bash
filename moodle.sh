#!/bin/bash
#Comprovem usuari

if [ $(whoami) == "root" ]; then
	echo -e "Eres root."
else
	echo "No eres root"
	echo "Para instalar los paquetes necesarios has de iniciar sesion como root."
	exit
fi

#Actualización de paquetes

apt-get update>dev/null 2>&1

#Instalación del paquete LAMP

#Instalación del Apache2
if [ $(dpkg-query -W -f='${Status}' 'apache2' | grep -c "ok installed") -eq 0 ];then 

	echo "Apache2 no esta instalado" >/script/registro.txt

	apt-get -y install apache2 >/dev/null 2>&1

	if [ $? -eq 0 ];then

		echo "Apache2 se ha instalado correctamente." >/script/registro.txt
		echo "Apache2 se ha instalado correctamente."

	else

		echo "Apache2 no se ha instalado correctamente." >/script/registro.txt
		echo "Apache2 se ha instalado correctamente." 

	fi
else
	echo "Apache2 ya esta instalado"
fi

#Instalación del paquete mariadb-server versión 10.4

if [ $(dpkg-query -W -f='${Status}' 'mariadb-server' | grep -c "ok installed") -eq 0 ];then 
	echo "Mariadv-server no esta instalado" 
	echo "Mariadv-server no esta instalado" >>/script/registro.txt

	apt-get install software-propierties-common dirmngr >/dev/null 2>&1
	apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xF1656F24C74CD1D8 >/dev/null 2>&1
	add-apt-repository ‘deb [arch=amd64] http://mirror.rackspace.com/mariadb/repo/10.4/debian buster main’ >/dev/null 2>&1
	apt-get update >/dev/null 2>&1
	apt-get install mariadb-server >/dev/null 2>&1
	
	if [ $? -eq 0 ];then
		echo "Mariadb-server se ha instalado correctamente." >>/script/registro.txt
		echo "Mariadb-server se ha instalado correctamente."
	else
		echo "Mariadb-server no se ha instalado correctamente." >>/script/registro.txt
		echo "Mariadb-server no se ha instalado correctamente."
	fi
else
	echo "Mariadb-server està instal.lat" >>/script/registro.txt
	echo "Mariadb-server està instal.lat" 
fi

#Instalación del paquete php 7.4
if [ $(dpkg-query -W -f='${Status}' 'php' | grep -c "ok installed") -eq 0 ];then 
	echo “PHP no está instalado” >>/script/registro.txt
	echo “PHP no está instalado”

	apt -y install lsb-release apt-transport-https ca-certificates >/dev/null 2>&1
	wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg >/dev/null 2>&1
	echo “deb https://packages.sury.org/php/ $( lsb_release -sc) main” | tee /etc/apt/sources.list.d/php.list >/dev/null 2>&1
	apt-get update >/dev/null 2>&1
	apt-get install php7.4 >/dev/null 2>&1
	if [ $? -eq 0 ];then
		echo "PHP 7.4 se ha instalado correctamente"
		echo "PHP 7.4 se ha instalado correctamente" >>/script/registro.txt
	else
		echo "php 7.4 no se ha instalado correctamente"
		echo "php 7.4 no se ha instalado correctamente" >>/script/registro.txt
	fi
else
	echo "PHP ya esta instalado"
	echo "PHP ya esta instalado" >>/script/registro.txt
fi

# Instalación de las expansiones de php

# Instalación de php-xml
if [ $(dpkg-query -W -f='${Status}' 'php7.4-xml' | grep -c "ok installed") -eq 0 ];then 
	
	echo "php-xml no esta instalado" 
	echo "php-xml no esta instalado" >>/script/registro.txt

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
	
	echo "php-mbstring no esta instalado"
	echo "php-mbstring no esta instalado" >>/script/registro.txt

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

	echo "php-curl no esta instalado"
	echo "php-curl no esta instalado" >>/script/registro.txt

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

	echo "php-zip no esta instalado"
	echo "php-zip no esta instalado" >>/script/registro.txt

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

	echo "php-zip no esta instalado"
	echo "php-zip no esta instalado" >>/script/registro.txt

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

	echo "php-zip no esta instalado"
	echo "php-zip no esta instalado" >>/script/registro.txt

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

	echo "php-soap no esta instalado"
	echo "php-soap no esta instalado" >>/script/registro.txt

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

#Creación de la base de datos para el servidor y Comprobación de que la base de datos ha sido creada

dbname="moodle"
if [ -d "/var/lib/mysql/$dbname" ]; then   (-d = directorio)
	echo "La base de datos moodle existe"
	echo "La base de datos moodle existe" >>/script/registro.txt
else 	
	echo "La base de datos moodle no existe"
	echo "Iniciando la instalación de la base de datos moodle"
	echo "La base de datos moodle no existe" >>/script/registro.txt
	echo "Iniciando la instalación de la base de datos moodle" >>/script/registro.txt

	mysql -u root -e "CREATE DATABASE moodle;"
	mysql -u root -e "CREATE USER 'moodle'@'localhost' IDENTIFIED BY 'moodle';"
	mysql -u root -e "GRANT ALL PRIVILEGES ON moodle.* TO 'moodle'@'localhost';
	mysql -u root -e "FLUSH PRIVILEGES;"
	mysql -u root -e "quit;"
	
	echo "Instalación hecha" >>/script/registro.txt
	echo "Instalación hecha"  
fi


#Redirrecion al directorio opt
cd /opt/ >/dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "Dirigirse al directorio opt" 
	echo "Dirigirse al directorio opt" >>/script/registro.txt
else
    echo "Error al dirigirse al directorio opt"
	echo "Error al dirigirse al directorio opt" >>/script/registro.txt
fi

#Descarga del servidor moodle
wget https://download.moodle.org/download.php/direct/stable401/moodle-latest-401.tgz >/dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "Descargando el archivo moodle en el directorio opt"
	echo "Descargando el archivo moodle en el directorio opt" >>/script/registro.txt
else
    echo "Error al descargar el archivo moodle"
	echo "Error al descargar el archivo moodle" >>/script/registro.txt
fi

#Descomprimir el archivo moodle
tar zxvf moodle-latest-401.tgz >/dev/null 2>&1
if [ $? -eq 0 ]; then
	echo "La extracción del archivo moodle fue exitosa"
	echo "La extracción del archivo moodle fue exitosa" >>/script/registro.txt
else
	echo "Error en la extracción del archivo moodle"
	echo "Error en la extracción del archivo moodle" >>/script/registro.txt
fi

#Eliminación del fichero index
rm /vat/www/html/index.html >/dev/null 2>&1
if [ $? -eq 0 ];then
	echo "La eliminación del fichero index fue exitosa"
	echo "La eliminación del fichero index fue exitosa" >>/script/registro.txt
else
	echo "Error en la eliminación del fichero"
	echo "Error en la eliminación del fichero" >>/script/registro.txt
fi

#Cambiar de directorio el archivo moodle
mv moodle/* /var/www/html/ >/dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "El cambio de directorio se realizó correctamente"
	echo "El cambio de directorio se realizó correctamente" >>/script/registro.txt
else
    echo "Error al cambiar de directorio"
	echo "Error al cambiar de directorio" >>/script/registro.txt
fi

#Crear el directorio necesario para el moodle 
mkdir /var/www/moodledata >/dev/null 2>&1
if [ $? -eq 0 ];then
	echo "La carpeta moodledata se creo correctamente"
	echo "La carpeta moodledata se creo correctamente" >>/script/registro.txt
else
	echo "La carpeta no pudo crearse"
	echo "La carpeta no pudo crearse" >>/script/registro.txt
fi

#Añadir los permisos necesarios 
chmod -R 755 /var/www/ >/dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "Se añadieron los permisos necesarios correctamente"
	echo "Se añadieron los permisos necesarios correctamente" >>/script/registro.txt
else
    echo "No se añadieron los permisos necesarios"
	echo "No se añadieron los permisos necesarios" >>/script/registro.txt
fi

#Cambio de propietario
chown -R www-data:www-data /var/www/ >/dev/null 2>&1
if [ $? -eq 0 ]; then
	echo "El cambio de propietario se realizó correctamente"
    echo "El cambio de propietario se realizó correctamente" >>/script/registro.txt
else
	echo "Error al cambiar de propietario"
    echo "Error al cambiar de propietario" >>/script/registro.txt
fi

		
