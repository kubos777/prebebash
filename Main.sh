#!/bin/bash

#Pograma principal

trap "" 2 20
trap "" SIGTSTP  #Trampas para detener las señales de Ctrl-z y Ctrl-c
printf "\033c"		#cls

exi=0
while [ "$f" != 'salir' ] && [ $exi != 3 ]; do  #Primer entrada, almenos que se escriba salir o se equicoque tres veces el usuario lo  no lo botará del sistema
	cdo=$PWD
	echo -e -n "\033[32m Name of the user: \033[00m" #Obtener datos para logeo
	read usser  
	echo -e -n "\033[32m Password of the user: \033[00m"
	read -s pswd

	cadena=`echo "$pswd" | sudo -S grep -r "$usser" /etc/shadow`

	if [ ${cadena} > 5 ];then #Si el usuario existe

		a=`grep mkpasswd /usr/bin/mkpasswd`
		if [ $a != "Binary file /usr/bin/mkpasswd matches" ];then
			echo "$pswd" | sudo -S  apt-get install whois #Instala el modulo o lo reinstala en dado caso
		fi
	

		IFS='$' read -r -a array <<< "$cadena"  #Detemrinamos el tipo de cifrado y el salt.
		if [ ${array[1]} == 1 ];then
 		   tencript="md5"
		elif [ ${array[1]} == 2 ];then
		    tencript="Blowfish"
		elif [ ${array[1]} == "2a" ];then
		    tencript="eksblowfish"         #Determinamos que tipo de cifrado usar.
		elif [ ${array[1]} == 5 ];then
 		   tencript="sha-256"
		elif [ ${array[1]} == 6 ];then
		    tencript="sha-512"
		fi
		con=`mkpasswd --method=$tencript --salt=${array[2]} $pswd`
		c=":"
		final=$usser$c$con #Contraseña.	

#Todo el proceso de arriba sirve para determinar  la contraseña de usuario.

		if [[ $cadena == *$final* ]];then  #Validación de la contraseña con a firma

		promt="#"
		printf "\033c" #CLS
		echo -e "\033[36m"
		echo "--------Bienvenido a la PreBeshell--------"
		echo "Presione cualquier tecla cuando este listo." #Menú de entrada
		echo -e "\033[00m"   #Se espara 5 segundos o hasta que se de un click para continuar
		read -n1 -t5 

		printf "\033c"

		while [ "$f"  != 'salir' ];do #Comandos a ingresar
		echo  -e -n "\033[36m$usser@$PWD$promt \033[00m"   #-n para quitar salto y -e para permitir colores
		read  f
		if [ "$f"  == "ayuda" ];then
			cd $cdo
			/bin/bash ./generales.sh ayuda
		elif [ "$f"  == "cls" ];then
			cd $cdo
			printf "\033c"
		elif [ "$f"  == "infosis" ];then
			cd $cdo
			/bin/bash ./generales.sh infosis $pswd
		elif [ "$f"  == "arbol" ];then
			cd $cdo
			/bin/bash ./generales.sh arbol $cdo
		elif [ "$f"  == "fecha" ];then
			cd $cdo
			/bin/bash ./generales.sh fecha
		elif [ "$f"  == "hora" ];then
			cd $cdo
			/bin/bash ./generales.sh hora
			sh ./generales.sh hora
			cd $cdo
		elif [ "$f"  == "busca"  ];then
			cd $cdo
			/bin/bash ./generales.sh 
		elif [ "$f"  == "4096"  ];then
			cd $cdo
			/bin/bash ./4096.sh
		elif [ "$f" == "ahorcado" ];then
			cd $cdo
			/bin/bash ./ahorcado.sh
		elif [ "$f"  == "creditos"  ];then
			cd $cdo
			/bin/bash ./generales.sh creditos
		elif [ "$f" == "prebeplayer" ];then
			cd $cdo
			/bin/bash ./PrebePlayer.sh $pswd
        elif [ "$f" == "salir" ];then
            exit 1
		else
			$f
		fi
#Lo anterior son los comandos que puede utilizar nuestra bash

		done
	else
	echo -e "\033[31mVerifique los datos\033[00m"
	read -n1 -t5 
	let exi=$exi+1
#Para cuando el usuario se equivova, le avisa que hay un error, y aumenta el contador  para botarlo posiblemente.
	fi
	else
	echo -e "\033[31mVerifique los datos\033[00m"
	read -n1 -t5 
	let exi=$exi+1
	fi
done