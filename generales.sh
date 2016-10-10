#!/bin/bash
#Pograma de opciones

#Comando de la fecha
if [ "$1" == "fecha" ];then
	echo -e "\e[95m"
	date "+Fecha actual: %Y-%m-%d%n"
#Comando de la hora
elif [ "$1" == "hora" ];then
	echo -e "\e[95m"
	date "+Hora actual: %H:%M:%S"
#Comando del arbol -No util aún
elif [ "$1" == "arbol" ]; then
	declare -i puntos=0;
	echo -e "\n"

function listf {
	cd $1
    for file in *
    do
        for ((i=0; $i < $puntos; i++))
        do
            printf "\e[33m\E[2m|+++\e[00m";
        done
        if [ -d "$file" ];then
            printf "\e[91m/";
        fi
        printf "$file\e[0m\n";
        if [ -d "$file" ]
        then
            puntos=$puntos+1;
            listf "$file";
            cd ..;
        fi
    done
    let puntos=$puntos-1;
}
listf "$1";

unset i color stackheight;

echo -e "\n"
#CComando de ayuda -> dah.
elif [ "$1" == "ayuda" ]; then

	echo "Menú de ayuda"
	echo -e "\e[91minfosis:\e[00m despliega información de la computadora"
	echo -e "\e[91marbol:\e[00m despliega una simulación del comando tree restringida a la carpeta actual"
	echo -e "\e[91mfecha:\e[00m despliega de la fecha actual"
	echo -e "\e[91mhora:\e[00m despliega la hora local"
	echo -e "\e[91mbusca:\e[00m [nombre] [directorio] : busca un archivo"
	echo -e "\e[91m4096:\e[00m Juego de 4096"
	echo -e "\e[91mahorcado:\e[00m Juego de ahorcado"
	echo -e "\e[91mprebeplayer:\e[00m Reproductor de música"
	echo -e "\e[91mcreditos:\e[00m datos de los programadores"
	echo -e "\e[91mcls:\e[00m limpia la pantalla"
	echo ""
#Datos de los desarolladores.
elif [ "$1" == "creditos" ]; then
	echo "Proyecto realizado por"
	echo "Gutiérrez Castillo Oscar"
	echo "Chavez Jorge ->"
	echo "Vargas Daniel"
#Datos de la máquina en operación
elif [ "$1"  == "infosis" ];then
	echo -n "Fabricante del equipo: " 
	echo "$2" | sudo -S dmidecode -s system-manufacturer
	echo -n "Nombre del producto: "
	echo "$2" | sudo -S dmidecode -s system-product-name
	echo -n "Versión del producto: "
	echo "$2" |sudo -S dmidecode -s system-version
	echo -n "# de serie del equipo: "
	echo "$2" | sudo - Sdmidecode -s system-serial-number
	echo  "Detalles del procesador"
	grep 'vendor_id' /proc/cpuinfo ; grep 'model name' /proc/cpuinfo ; grep 'cpu MHz' /proc/cpuinfo
	echo -n "Estado de la bateria:"
	acpi -bi
	echo -n "Nombre y versión del kernel: "
	unama -sr
	echo -n "Distribución: "
	lsb_release -idc
	echo "Espacio en el disco duro y particiones"
	df -h


fi