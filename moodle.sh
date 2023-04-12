#!/bin/bash

#Colores de texto
Defecto='\e[39m'
Rojo='\e[31m'
Verde='\e[32m'
Azul='\e[34m'
subrayado='\e[4m' 

#Lista de todos los paquetes
echo "Esta apunto de instalar el servidor moodle y con ello todos los siguientes paquetes: "
echo "${Azul}1)apache2 2)mariadb-server 3)php 4)php-mysql 5)php-zip 6)php-curl 7)php-xml 8)php-mbstring"
echo "9)php-gd 10)php-soap 11)php-intl 12)software-properties-common 13)dirmngr${Defecto}"

#Confirmación de la instalación
read -p "${subrayado}Estas seguro de proceder con la instalación (S/N):${Defecto} " confirmacion
if [ "${confirmacion}" != "S" ];then
	exit
else
	echo "Procederemos a comprobar si tienes los permisos como root"
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
if [ $(dpkg-query -W -f='${Status}' 'apache2' | grep -c "ok installed") -eq 0 ];then 
	echo -e "${Azul}Apache2${Defecto} no esta instalado"
	echo -e "${Azul}Apache2${Defecto} no esta instalado" >/script/registro.txt
	apt-get -y install apache2 >/dev/null 2>&1

	if [ $? -eq 0 ];then
		echo -e "${Azul}Apache2${Defecto} ${Verde}se ha instalado correctamente${Defecto}" >>/script/registro.txt
		echo -e "${Azul}Apache2${Defecto} ${Verde}se ha instalado correctamente${Defecto}"
	else
		echo -e "${Azul}Apache2${Defecto} ${Rojo}no se ha instalado correctamente ${Defecto}"  >>/script/registro.txt
		echo -e "${Azul}Apache2${Defecto} ${Rojo}no se ha instalado correctamente ${Defecto}" 
	fi
else
	echo "Apache2 ya esta instalado" >>/script/registro.txt
	echo "Apache2 ya esta instalado"
fi

#Instalación del paquete mariadb-server versión 10.4

#Instalación del software-propierties-common 
if [ $(dpkg-query -W -f='${Status}' 'software-properties-common' | grep -c "ok installed") -eq 0 ];then 
	echo -e "${Azul}software-properties-common${Defecto} no esta instalado" 
	echo -e "${Azul}software-properties-common${Defecto} no esta instalado" >>/script/registro.txt

	apt-get -y install software-properties-common  >/dev/null 2>&1
	if [ $? -eq 0 ];then
		echo -e "${Azul}software-properties-common${Defecto} ${Verde}se ha instalado correctamente${Defecto}" >>/script/registro.txt
		echo -e "${Azul}software-properties-common${Defecto} ${Verde}se ha instalado correctamente${Defecto}"
	else
		echo -e "${Azul}software-properties-common${Defecto} ${Rojo}no se ha instalado correctamente${Defecto}" >>/script/registro.txt
		echo -e "${Azul}software-properties-common${Defecto} ${Rojo}no se ha instalado correctamente${Defecto}"
	fi
else
	echo -e "${Azul}software-properties-common${Defecto} esta instalado" >>/script/registro.txt
	echo -e "${Azul}software-properties-common${Defecto} esta instalado" 
fi

#Instalación del dirmngr
if [ $(dpkg-query -W -f='${Status}' 'dirmngr' | grep -c "ok installed") -eq 0 ];then 
	echo -e "${Azul}dirmngr${Defecto} no esta instalado" 
	echo -e "${Azul}dirmngr${Defecto} no esta instalado" >>/script/registro.txt

	apt-get -y install dirmngr >/dev/null 2>&1
	if [ $? -eq 0 ];then
		echo -e "${Azul}dirmngr${Defecto} ${Verde}se ha instalado correctamente${Defecto}" >>/script/registro.txt
		echo -e "${Azul}dirmngr${Defecto} ${Verde}se ha instalado correctamente${Defecto}"
	else
		echo -e "${Azul}dirmngr${Defecto} ${Rojo}no se ha instalado correctamente${Defecto}" >>/script/registro.txt
		echo -e "${Azul}dirmngr${Defecto} ${Rojo}no se ha instalado correctamente${Defecto}"
	fi
else
	echo -e "${Azul}dirmngr${Defecto} esta instalado" >>/script/registro.txt
	echo -e "${Azul}dirmngr${Defecto} esta instalado" 
fi

#Inserción de la clave
apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xF1656F24C74CD1D8 >/dev/null 2>&1

if [ $? -eq 0 ];then
	echo -e "${Verde}La clave se colocó correctamente${Defecto}"
	echo -e "${Verde}La clave se colocó correctamente${Defecto}" >>/script/registro.txt
else
	echo -e "${Rojo}Error en la clave${Defecto}"
	echo -e "${Rojo}Error en la clave${Defecto}" >>/script/registro.txt
fi

#Repositorio del mariadb
add-apt-repository 'deb [arch=amd64] http://mirror.rackspace.com/mariadb/repo/10.4/debian buster main' >/dev/null 2>&1

if [ $? -eq 0 ];then
	echo -e "${Verde}El repositorio se colocó correctamente${Defecto}"
	echo -e "${Verde}El repositorio se colocó correctamente${Defecto}" >>/script/registro.txt
else
	echo -e "${Rojo}El repositorio no se coloco correctamente${Defecto}"
	echo -e "${Rojo}El repositorio no se coloco correctamente${Defecto}" >>/script/registro.txt
fi

#Actualización de los paquetes
apt-get update >/dev/null 2>&1


#Instalación del mariadb-server 
if [ $(dpkg-query -W -f='${Status}' 'mariadb-server' | grep -c "ok installed") -eq 0 ];then 
	echo -e "${Azul}Mariadb-server${Defecto} no esta instalado" 
	echo -e "${Azul}Mariadb-server${Defecto} no esta instalado" >>/script/registro.txt

	apt-get -y install mariadb-server >/dev/null 2>&1
	apt-get update >/dev/null 2>&1
	apt-get -y install mariadb-server >/dev/null 2>&1

	if [ $? -eq 0 ];then
		echo -e "${Azul}Mariadb-server${Defecto} ${Verde}se ha instalado correctamente${Defecto}" >>/script/registro.txt
		echo -e "${Azul}Mariadb-server${Defecto} ${Verde}se ha instalado correctamente${Defecto}"
	else
		echo -e "${Azul}Mariadb-server${Defecto} ${Rojo}no se ha instalado correctamente${Defecto}" >>/script/registro.txt
		echo -e "${Azul}Mariadb-server${Defecto} ${Rojo}no se ha instalado correctamente${Defecto}"
	fi
else
	echo -e "${Azul}Mariadb-server${Defecto} esta instalado" >>/script/registro.txt
	echo -e "${Azul}Mariadb-server${Defecto} esta instalado" 
fi

#Instalación del paquete php 7.4
if [ $(dpkg-query -W -f='${Status}' 'php7.4' | grep -c "ok installed") -eq 0 ];then 
	echo -e "${Azul}Php${Defecto} no está instalado" >>/script/registro.txt
	echo -e "${Azul}Php${Defecto} no está instalado"

	apt -y install lsb-release apt-transport-https ca-certificates >/dev/null 2>&1
	wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg >/dev/null 2>&1
	echo "deb https://packages.sury.org/php/ $( lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list >/dev/null 2>&1
	apt-get update >/dev/null 2>&1
	apt-get -y install php7.4 >/dev/null 2>&1
	if [ $? -eq 0 ];then
		echo -e "${Azul}php 7.4${Defecto} ${Verde}se ha instalado correctamente${Defecto}"
		echo -e "${Azul}php 7.4${Defecto} ${Verde}se ha instalado correctamente${Defecto}" >>/script/registro.txt
	else
		echo -e "${Azul}php 7.4${Defecto} ${Rojo}no se ha instalado correctamente${Defecto}"
		echo -e "${Azul}php 7.4${Defecto} ${Rojo}no se ha instalado correctamente${Defecto}" >>/script/registro.txt
	fi
else
	echo -e "${Azul}Php${Defecto} ya esta instalado"
	echo -e "${Azul}Php${Defecto} ya esta instalado" >>/script/registro.txt
fi

# Instalación de las expansiones de php

# Instalación de php-mysql
if [ $(dpkg-query -W -f='${Status}' 'php7.4-mysql' | grep -c "ok installed") -eq 0 ];then 
	
	echo -e "${Azul}php-mysql${Defecto} no esta instalado" 
	echo -e "${Azul}php-mysql${Defecto} no esta instalado" >>/script/registro.txt
	apt-get update >/dev/null 2>&1
	apt-get -y install php7.4-mysql  >/dev/null 2>&1

	if [ $? -eq 0 ];then

		echo -e "${Azul}php-mysql${Defecto} ${Verde}se ha instalado correctamente${Defecto}" >>/script/registro.txt
		echo -e "${Azul}php-mysql${Defecto} ${Verde}se ha instalado correctamente${Defecto}"
	else
		echo -e "${Azul}php-mysql${Defecto} ${Rojo}no se ha instalado correctamente${Defecto}"
		echo -e "${Azul}php-mysql${Defecto} ${Rojo}no se ha instalado correctamente${Defecto}" >>/script/registro.txt
	fi
else
	echo -e "${Azul}php-mysql${Defecto} ya esta instalado" >>/script/registro.txt
	echo -e "${Azul}php-mysql${Defecto} ya esta instalado"
fi

# Instalación de php-xml
if [ $(dpkg-query -W -f='${Status}' 'php7.4-xml' | grep -c "ok installed") -eq 0 ];then 
	
	echo -e "${Azul}php-xml${Defecto} no esta instalado" 
	echo -e "${Azul}php-xml${Defecto} no esta instalado" >>/script/registro.txt
	apt-get update >/dev/null 2>&1
	apt-get -y install php7.4-xml  >/dev/null 2>&1

	if [ $? -eq 0 ];then

		echo -e "${Azul}php-xml${Defecto} ${Verde}se ha instalado correctamente${Defecto}" >>/script/registro.txt
		echo -e "${Azul}php-xml${Defecto} ${Verde}se ha instalado correctamente${Defecto}"
	else
		echo -e "${Azul}php-xml${Defecto} ${Rojo}no se ha instalado correctamente${Defecto}"
		echo -e "${Azul}php-xml${Defecto} ${Rojo}no se ha instalado correctamente${Defecto}" >>/script/registro.txt
	fi
else
	echo -e "${Azul}php-xml${Defecto} ya esta instalado" >>/script/registro.txt
	echo -e "${Azul}php-xml${Defecto} ya esta instalado"
fi

# Instalación de php-mbstring
if [ $(dpkg-query -W -f='${Status}' 'php7.4-mbstring' | grep -c "ok installed") -eq 0 ];then 
	
	echo -e "${Azul}php-mbstring${Defecto} no esta instalado"
	echo -e "${Azul}php-mbstring${Defecto} no esta instalado" >>/script/registro.txt
	apt-get -y install php7.4-mbstring >/dev/null 2>&1

	if [ $? -eq 0 ];then
		echo -e "${Azul}php-mbstring${Defecto} ${Verde}se ha instalado correctamente${Defecto}" >>/script/registro.txt
		echo -e "${Azul}php-mbstring${Defecto} ${Verde}se ha instalado correctamente${Defecto}"

	else
		echo -e "${Azul}php-mbstring${Defecto} ${Rojo}no se ha instalado correctamente${Defecto}"
		echo -e "${Azul}php-mbstring${Defecto} ${Rojo}no se ha instalado correctamente${Defecto}" >>/script/registro.txt
	fi
else
	echo -e "${Azul}php-mbstring${Defecto} ya esta instalado" >>/script/registro.txt
	echo -e "${Azul}php-mbstring${Defecto} ya esta instalado"
fi

# Instalación de php-curl
if [ $(dpkg-query -W -f='${Status}' 'php7.4-curl' | grep -c "ok installed") -eq 0 ];then 

	echo -e "${Azul}php-curl${Defecto} no esta instalado"
	echo -e "${Azul}php-curl${Defecto} no esta instalado" >>/script/registro.txt
	apt-get -y install php7.4-curl >/dev/null 2>&1

	if [ $? -eq 0 ];then
		echo -e "${Azul}php-curl${Defecto} ${Verde}se ha instalado correctamente${Defecto}" >>/script/registro.txt
		echo -e "${Azul}php-curl${Defecto} ${Verde}se ha instalado correctamente${Defecto}"
	else
		echo -e "${Azul}php-curl${Defecto} ${Rojo}no se ha instalado correctamente${Defecto}"
		echo -e "${Azul}php-curl${Defecto} ${Rojo}no se ha instalado correctamente${Defecto}" >>/script/registro.txt
	fi
else
	echo -e "${Azul}php-curl${Defecto} ya esta instalado" >>/script/registro.txt
	echo -e "${Azul}php-curl${Defecto} ya esta instalado"
fi

# Instalación de php-zip
if [ $(dpkg-query -W -f='${Status}' 'php7.4-zip' | grep -c "ok installed") -eq 0 ];then

	echo -e "${Azul}php-zip${Defecto} no esta instalado"
	echo -e "${Azul}php-zip${Defecto} no esta instalado" >>/script/registro.txt
	apt-get -y install php7.4-zip >/dev/null 2>&1

	if [ $? -eq 0 ];then
		echo -e "${Azul}php-zip${Defecto} ${Verde}se ha instalado correctamente${Defecto}" >>/script/registro.txt
		echo -e "${Azul}php-zip${Defecto} ${Verde}se ha instalado correctamente${Defecto}"
	else
		echo -e "${Azul}php-zip${Defecto} ${Rojo}no se ha instalado correctamente${Defecto}"
		echo -e "${Azul}php-zip${Defecto} ${Rojo}no se ha instalado correctamente${Defecto}" >>/script/registro.txt
	fi
else
	echo -e "${Azul}php-zip${Defecto} ya esta instalado" >>/script/registro.txt
	echo -e "${Azul}php-zip${Defecto} ya esta instalado"
fi

# Instalación de php-gd
if [ $(dpkg-query -W -f='${Status}' 'php7.4-gd' | grep -c "ok installed") -eq 0 ];then

	echo -e "${Azul}php-gd${Defecto} no esta instalado"
	echo -e "${Azul}php-gd${Defecto}no esta instalado" >>/script/registro.txt
	apt-get -y install php7.4-gd >/dev/null 2>&1

	if [ $? -eq 0 ];then
		echo -e "${Azul}php-gd${Defecto} ${Verde}se ha instalado correctamente${Defecto}" >>/script/registro.txt
		echo -e "${Azul}php-gd${Defecto} ${Verde}se ha instalado correctamente${Defecto}"

	else
		echo -e "${Azul}php-gd${Defecto} ${Rojo}no se ha instalado correctamente${Defecto}"
		echo -e "${Azul}php-gd${Defecto} ${Rojo}no se ha instalado correctamente${Defecto}" >>/script/registro.txt
	fi
else
	echo -e "${Azul}php-gd${Defecto} ya esta instalado" >>/script/registro.txt
	echo -e "${Azul}php-gd${Defecto} ya esta instalado"
fi

# Instalación de php-intl
if [ $(dpkg-query -W -f='${Status}' 'php7.4-intl' | grep -c "ok installed") -eq 0 ];then

	echo -e "${Azul}php-intl${Defecto} no esta instalado"
	echo -e "${Azul}php-intl${Defecto} no esta instalado" >>/script/registro.txt
	apt-get -y install php7.4-intl >/dev/null 2>&1

	if [ $? -eq 0 ];then
		echo -e "${Azul}php-intl${Defecto} ${Verde}se ha instalado correctamente${Defecto}" >>/script/registro.txt
		echo -e "${Azul}php-intl${Defecto} ${Verde}se ha instalado correctamente${Defecto}"
	else
		echo -e "${Azul}php-intl${Defecto} ${Rojo}no se ha instalado correctamente${Defecto}"
		echo -e "${Azul}php-intl${Defecto} ${Rojo}no se ha instalado correctamente${Defecto}" >>/script/registro.txt
	fi
else
	echo -e "${Azul}php-intl${Defecto} ya esta instalado" >>/script/registro.txt
	echo -e "${Azul}php-intl${Defecto} ya esta instalado"
fi

# Instalación de php-soap
if [ $(dpkg-query -W -f='${Status}' 'php7.4-soap' | grep -c "ok installed") -eq 0 ];then

	echo -e "${Azul}php-soap${Defecto} no esta instalado"
	echo -e "${Azul}php-soap${Defecto} no esta instalado" >>/script/registro.txt
	apt-get -y install php7.4-soap >/dev/null 2>&1

	if [ $? -eq 0 ];then
		echo -e "${Azul}php-soap${Defecto} ${Verde}se ha instalado correctamente${Defecto}" >>/script/registro.txt
		echo -e "${Azul}php-soap${Defecto} ${Verde}se ha instalado correctamente${Defecto}"
	else
		echo -e "${Azul}php-soap${Defecto} ${Rojo}no se ha instalado correctamente${Defecto}"
		echo -e "${Azul}php-soap${Defecto} ${Rojo}no se ha instalado correctamente${Defecto}" >>/script/registro.txt
	fi
else
	echo -e "${Azul}php-soap${Defecto} ya esta instalado" >>/script/registro.txt
	echo -e "${Azul}php-soap${Defecto} ya esta instalado"
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
	
	echo -e "${Verde}Creación exitosa${Defecto}" >>/script/registro.txt
	echo -e "${Verde}Creación exitosa${Defecto}"  
fi


#Redirrecion al directorio opt
cd /opt/ >/dev/null 2>&1
if [ $? -eq 0 ]; then
	echo "Dirigirse al directorio opt" 
	echo "Dirigirse al directorio opt" >>/script/registro.txt
else
	echo -e "${Rojo}Error al dirigirse al directorio opt${Defecto}"
	echo -e "${Rojo}Error al dirigirse al directorio opt${Defecto}" >>/script/registro.txt
fi

#Descarga del servidor moodle
wget https://download.moodle.org/download.php/direct/stable401/moodle-latest-401.tgz >/dev/null 2>&1
if [ $? -eq 0 ]; then
	echo -e "${Verde}Descarga exitosa del archivo moodle${Defecto}"
	echo -e "${Verde}Descarga exitosa del archivo moodle${Defecto}" >>/script/registro.txt
else
	echo -e "${Rojo}Error al descargar el archivo moodle${Defecto}"
	echo -e "${Rojo}Error al descargar el archivo moodle${Defecto}" >>/script/registro.txt
fi

#Descomprimir el archivo moodle
tar zxvf moodle-latest-401.tgz >/dev/null 2>&1
if [ $? -eq 0 ]; then
	echo -e "${Verde}La extracción del archivo moodle fue exitosa${Defecto}"
	echo -e "${Verde}La extracción del archivo moodle fue exitosa${Defecto}" >>/script/registro.txt
else
	echo -e "${Rojo}Error en la extracción del archivo moodle${Defecto}"
	echo -e "${Rojo}Error en la extracción del archivo moodle${Defecto}" >>/script/registro.txt
fi

#Eliminación del fichero index
rm /var/www/html/index.html >/dev/null 2>&1
if [ $? -eq 0 ];then
	echo -e "${Verde}La eliminación del fichero index fue exitosa${Defecto}"
	echo -e "${Verde}La eliminación del fichero index fue exitosa${Defecto}" >>/script/registro.txt
else
	echo -e "${Rojo}Error en la eliminación del fichero${Defecto}"
	echo -e "${Rojo}Error en la eliminación del fichero${Defecto}" >>/script/registro.txt
fi

#Cambiar de directorio el archivo moodle
mv moodle/ /var/www/html/ >/dev/null 2>&1
if [ $? -eq 0 ]; then
	echo -e "${Verde}El cambio de directorio se realizó correctamente${Defecto}"
	echo -e "${Verde}El cambio de directorio se realizó correctamente${Defecto}" >>/script/registro.txt
else
	echo -e "${Rojo}Error al cambiar de directorio${Defecto}"
	echo -e "${Rojo}Error al cambiar de directorio${Defecto}" >>/script/registro.txt
fi

#Crear el directorio necesario para el moodle 
mkdir /var/www/moodledata >/dev/null 2>&1
if [ $? -eq 0 ];then
	echo -e "${Verde}La carpeta moodledata se creo correctamente${Defecto}"
	echo -e "${Verde}La carpeta moodledata se creo correctamente${Defecto}" >>/script/registro.txt
else
	echo -e "${Rojo}La carpeta no pudo crearse${Defecto}"
	echo -e "${Rojo}La carpeta no pudo crearse${Defecto}" >>/script/registro.txt
fi

#Añadir los permisos necesarios 
chmod -R 755 /var/www/ >/dev/null 2>&1
if [ $? -eq 0 ]; then
	echo -e "${Verde}Se añadieron los permisos necesarios correctamente${Defecto}"
	echo -e "${Verde}Se añadieron los permisos necesarios correctamente${Defecto}" >>/script/registro.txt
else
	echo -e "${Rojo}No se añadieron los permisos necesarios${Defecto}"
	echo -e "${Rojo}No se añadieron los permisos necesarios${Defecto}" >>/script/registro.txt
fi

#Cambio de propietario
chown -R www-data:www-data /var/www/ >/dev/null 2>&1
if [ $? -eq 0 ]; then
	echo -e "${Verde}El cambio de propietario se realizó correctamente${Defecto}"
	echo -e "${Verde}El cambio de propietario se realizó correctamente${Defecto}" >>/script/registro.txt
else
	echo -e "${Rojo}Error al cambiar de propietario${Defecto}"
	echo -e "${Rojo}Error al cambiar de propietario${Defecto}" >>/script/registro.txt
fi

#actualización de los paquetes y reinicio del servidor apache
apt-get -y upgrade >/dev/null 2>&1
if [ $? -eq 0 ];then
	echo -e "${Verde}La actualización se realizó correctamente${Defecto}"
	echo -e "${Verde}La actualización se realizó correctamente${Defecto}" >>/script/registro.txt
else
	echo -e "${Rojo}Error en la actualización${Defecto}"
	echo -e "${Rojo}Error en la actualización${Defecto}" >>/script/registro.txt
fi

systemctl restart apache2 >/dev/null 2>&1
if [ $? -eq 0 ];then
	echo -e "${Verde}Reinicio correcto${Defecto}"
	echo -e "${Verde}Reinicio correcto${Defecto}" >>/script/registro.txt
else
	echo -e "${Rojo}Error al reiniciar el servidor${Defecto}"
	echo -e "${Rojo}Error al reiniciar el servidor${Defecto}" >>/script/registro.txt
fi

echo "FIN DE LA INSTALACIÓN"