#!/bin/bash

#Variables globales
encontradas=(0)
palabra=0
letra=0
ganaste=0
perdiste=0
contaLose=0
foundLetter=0
salir=0
opc=0
n=0

#Función que verifica si existe un diccionario de palabras en la carpeta actual. Si no lo hay, lo crea.
function validaDiccionario ()
{
	encontrado=0
	for f in $( ls ); do 						#Se verifica si existe el diccionario en la carpeta actual
		if [ "$f" == "diccionario.txt" ]; then 
			encontrado=1
			break;
		fi
	done
	if [ "$encontrado" == "0" ]; then 			#Si no existe, se crea
		echo -e "videojuego\nprebecario\nbecario\nmonumento\nfacultad\ningeniero\ncomputadora\nencender\nlentes\nmentira\nprevenir
criptonita\ncarpintero\ndelito\nperpendicular\nrotar\ndibujar\ncuerno\ncebo\ntibio\ntarea\namuleto\nestructura
programa\nalgoritmo\nservidor\nreprobar\ninternet\ndato\nprotocolo\nencantador\ndefenderse\nidea\ninvisible
emergencia\nolimpiada\nente\nmanchas\nlenguaje\nencriptar\nsonido\nanticonstitucional\ngas\nasesinato\ndemonio
norte\npaz\nescuchar\nproceso\ninteresante" >> "diccionario.txt"
	fi
}

#Función que toma del diccionario de palabras una palabra al azar
function buscaPalabra()
{
	i=0
	aleatorio=$((RANDOM % 51)) 				#Se elige un númerp al azar
	for word in $(cat diccionario.txt); do
		if [ $i == $aleatorio ]; then
			palabra="$word"					#Se leen todas las palabras hasta que un contador llegue al número aleatorio
			break							#y se toma esa palabra la última palabra encontrada
		fi
		let i=$i+1
	done 
	echo -e "\e[1;35m¡Encontraste un easter egg, maldito ocioso! La palabra en juego es: \e[1;33m$word\e[0m" #Ignora esto
}

#Se busca la letra ingresada por el usuario en la palabra seleccionada
function buscaLetra()
{
	contaWinUp=0
	foundLetter=0
	for (( i=0; i<${#palabra}; i++ )); do 				#Se busca la letra ingresada en la palabra actual
  		if [ "$letra" == "${palabra:$i:1}" ]; then		#si existe, se agrega al vector de letras encontradas y
  			encontradas[$n]=$letra 						#se avisa que se encontró una letra (para otras funciones),
  			let n=$n+1							
  			foundLetter=1
  			for elemento in "$encontradas"; do 			#Se verifica si la letra ingresada ya había sido encontrada
  				if [ "$letra" != "$elemento" ]; then
  					nuevaletra=1						#Si no, se avisa que la letra es nueva caso contrario, pos' no.
  				else
  					nuevaletra=0
  					break
  				fi
  			done
  			if [ "$nuevaletra" == "1" ]; then			#Si se encontró una nueva letra, el contador de letras nuevas 
  				let contaWin=$contaWin+1				#aumenta, y más adelante definirá si se ganó o no;
  				nuevaletra=0
  			fi	
  		fi
  	done
 	
}

#Función que da valor a las variables que definen si ya se ganó o perdió
function winOrLose ()
{
	let letrasPalabra="${#palabra}"-1				 
  	if [ "$contaWin" == "$letrasPalabra" ]; then	#Si la cantidad de letras encontradas es igual a la cantidad
  		ganaste=1 									#de letras en la palabra, ¡ganaste!
  	fi

  	if [ "$foundLetter" == "0" ]; then 				
		let contaLose=$contaLose+1
	  		if [ "$contaLose" == "7" ]; then		#Si no encontraste una nueva letra en 7 turnos, perdiste :(
	  			perdiste=1
	  		fi
	fi
}

#Función que compara entre las letras de la palabra seleccionada y el vector de letras encontradas para ver
#cuáles letras ya se encontraron e imprimirlas o imprimir guiones bajos si faltan letras por encontrar
function imprimeEncontradas()
{
	found=0
	printf "\n\t\t\e[1;30mLa palabra es:  \e[0m"
	for (( i=0; i<${#palabra}; i++ )); do 							#Por cada letra de la palabra
  		for (( j=0; j<=$n; j++ )); do 								#Se busca dicha letra en el vector de 
  			if [ "${encontradas[$j]}" == "${palabra:$i:1}" ]; then	#letras encontradas
  				printf "\e[1;33m${encontradas[$j]} \e[0m"			#Si se encontró, se imprime dicha letra
  				let found=$found+1
  				break
  			fi
  		done
  		if [ "$found" == "0" ]; then								#Si no, se imprime un guión bajo
  			printf "_ "
  		fi
  		found=0
	done
}

#Función que imprimir al mono cuando te la rifaste
function imrimeGanador()
{
	echo -e ''
	echo -e '\e[0;33m\t\t\t\t     _______'
	echo -e '\e[0;33m\t\t\t\t    |/      |'
	echo -e '\e[0;33m\t\t\t\t    |       |'
	echo -e '\e[0;33m\t\t\t\t    |       |\t \e[1;33m_' 
	echo -e '\e[0;33m\t\t\t\t    |   \t\e[1;33m(_)\e[1;32m      ¡Gracias!'
	echo -e '\e[0;33m\t\t\t\t    |   \t\e[1;33m\|/\e[1;32m  ¡Me has salvado!'
	echo -e '\e[0;33m\t\t\t\t    |   \t\e[1;33m |'
	echo -e '\e[0;33m\t\t\t\tjgs_|___\t\e[1;33m/ \'
	echo -e ''
}

#Función que imprime los estados del mono ahorcado
function imprimeMono()
{
	case "$contaLose" in
		0)
			echo -e ''
			echo -e '\e[0;33m\t\t\t\t     _______'
			echo -e '\e[0;33m\t\t\t\t    |/      '
			echo -e '\e[0;33m\t\t\t\t    |      '
			echo -e '\e[0;33m\t\t\t\t    |      '
			echo -e '\e[0;33m\t\t\t\t    |      '
			echo -e '\e[0;33m\t\t\t\t    |      '
			echo -e '\e[0;33m\t\t\t\t    |'
			echo -e '\e[0;33m\t\t\t\tjgs_|___'
			echo -e ''
			;;
		1)
			echo -e ''
			echo -e '\e[0;33m\t\t\t\t     _______'
			echo -e '\e[0;33m\t\t\t\t    |/      |'
			echo -e '\e[0;33m\t\t\t\t    |      '
			echo -e '\e[0;33m\t\t\t\t    |      '
			echo -e '\e[0;33m\t\t\t\t    |      '
			echo -e '\e[0;33m\t\t\t\t    |      '
			echo -e '\e[0;33m\t\t\t\t    |'
			echo -e '\e[0;33m\t\t\t\tjgs_|___'
			echo -e ''
			;;
		2)
			echo -e ''
			echo -e '\e[0;33m\t\t\t\t     _______'
			echo -e '\e[0;33m\t\t\t\t    |/      |'
			echo -e '\e[0;33m\t\t\t\t    |      \e[1;33m(_)'
			echo -e '\e[0;33m\t\t\t\t    |      '
			echo -e '\e[0;33m\t\t\t\t    |       '
			echo -e '\e[0;33m\t\t\t\t    |      '
			echo -e '\e[0;33m\t\t\t\t    |'
			echo -e '\e[0;33m\t\t\t\tjgs_|___'
			echo -e ''
			;;
		3)
			echo -e ''
			echo -e '\e[0;33m\t\t\t\t     _______'
			echo -e '\e[0;33m\t\t\t\t    |/      |'
			echo -e '\e[0;33m\t\t\t\t    |      \e[1;33m(_)'
			echo -e '\e[0;33m\t\t\t\t    |      \e[1;33m\|/'
			echo -e '\e[0;33m\t\t\t\t    |       '
			echo -e '\e[0;33m\t\t\t\t    |      '
			echo -e '\e[0;33m\t\t\t\t    |'
			echo -e '\e[0;33m\t\t\t\tjgs_|___'
			echo -e ''
			;;
		4)
			echo -e ''
			echo -e '\e[0;33m\t\t\t\t     _______'
			echo -e '\e[0;33m\t\t\t\t    |/      |'
			echo -e '\e[0;33m\t\t\t\t    |      \e[1;33m(_)'
			echo -e '\e[0;33m\t\t\t\t    |      \e[1;33m\|/'
			echo -e '\e[0;33m\t\t\t\t    |      \e[1;33m |'
			echo -e '\e[0;33m\t\t\t\t    |      '
			echo -e '\e[0;33m\t\t\t\t    |'
			echo -e '\e[0;33m\t\t\t\tjgs_|___'
			echo -e ''
			;;
		5)
			echo -e ''
			echo -e '\e[0;33m\t\t\t\t     _______'
			echo -e '\e[0;33m\t\t\t\t    |/      |'
			echo -e '\e[0;33m\t\t\t\t    |      \e[1;33m(_)'
			echo -e '\e[0;33m\t\t\t\t    |     \e[1;33m \|/'
			echo -e '\e[0;33m\t\t\t\t    |      \e[1;33m |'
			echo -e '\e[0;33m\t\t\t\t    |      \e[1;33m/ \'
			echo -e '\e[0;33m\t\t\t\t    |'
			echo -e '\e[0;33m\t\t\t\tjgs_|___'
			echo -e ''
			;;
		6)
			echo -e ''
			echo -e '\e[0;33m\t\t\t\t     _______'
			echo -e '\e[0;33m\t\t\t\t    |/      |'
			echo -e '\e[0;33m\t\t\t\t    |       |'
			echo -e '\e[0;33m\t\t\t\t    |      \e[1;33m(_)'
			echo -e '\e[0;33m\t\t\t\t    |      \e[1;33m\|/'
			echo -e '\e[0;33m\t\t\t\t    |     \e[1;33m  |'
			echo -e '\e[0;33m\t\t\t\t    |     \e[1;33m / \'
			echo -e '\e[0;33m\t\t\t\tjgs_|___'
			echo -e ''
			;;
		7)
			echo -e ''
			echo -e '\e[0;33m\t\t\t\t     _______'
			echo -e '\e[0;33m\t\t\t\t    |/      |'
			echo -e '\e[0;33m\t\t\t\t    |       |'
			echo -e '\e[0;33m\t\t\t\t    |      \e[1;37m(_)'
			echo -e '\e[0;33m\t\t\t\t    |     \e[1;37m /|\'
			echo -e '\e[0;33m\t\t\t\t    |     \e[1;37m  |'
			echo -e '\e[0;33m\t\t\t\t    |      \e[1;37m/ \'
			echo -e '\e[0;33m\t\t\t\tjgs_|___'
			echo -e ''
			perdiste=1
			;;
		esac
}

#MENÚ PRINCIPAL
validaDiccionario
while [ "$salir" == 0 ]; do
	case "$opc" in
		0) #Se imprime el banner y menú de opciones  
			echo -e "\t\t\e[1;33m \n\n\n\t\t\t\tB I E N V E N I D O   A:\n"       
			echo -e "\t\t\e[1;37m\e[1;41m"'                ____            __'"                 \e[0m"                     
			echo -e "\t\t\e[1;37m\e[1;41m"'               / __ \________  / /_  ___'"           \e[0m"               
			echo -e "\t\t\e[1;37m\e[1;41m"'              / /_/ / ___/ _ \/ __ \/ _ \'"          \e[0m"             
			echo -e "\t\t\e[1;37m\e[1;41m"'             / ____/ /  /  __/ /_/ /  __/'"          \e[0m"               
			echo -e "\t\t\e[1;37m\e[1;41m"'     ___    / /   /_/   \___/_.___/\___/    __'"     \e[0m"          
			echo -e "\t\t\e[1;37m\e[1;41m"'    /   |  / /_  ____  ______________ _____/ /___'"  \e[0m"       
			echo -e "\t\t\e[1;37m\e[1;41m"'   / /| | / __ \/ __ \/ ___/ ___/ __ `/ __  / __ \' "\e[0m"      
			echo -e "\t\t\e[1;37m\e[1;41m"'  / ___ |/ / / / /_/ / /  / /__/ /_/ / /_/ / /_/ /' "\e[0m"     
			echo -e "\t\t\e[1;37m\e[1;41m"' /_/  |_/_/ /_/\____/_/   \___/\__,_/\__,_/\____/ ' "\e[0m" 
			echo -e "\t\t\e[1;37m\e[1;41m"'                                                  ' "\e[0m"
			echo -e "\e[1;33m\n\n\t\t    Selecciona una opción \e[0;33m(número+'enter')\e[1;33m:\e[1;37m\n\n\t\t\t      1) ¡Empezar a jugar!
			      2) Instrucciones\n\t\t\t      3) Agregar palabra al diccionario\n\t\t\t      4) Salir\n\t\t\t\e[0m"
			read opc
			;;
		1) #Empieza un juevo nuevo
			#Inicialización de las variables necesarias para jugar
			opc=0
			ganaste=0
			perdiste=0
			contaLose=0
			contaWin=0
			encontradas=(0)
			n=0

			buscaPalabra

			##Loop donde se ejecuta el juego hasta que ganes o pierdas
			while :;do
				#Se imprime el mono, luego las letras encontradas, luego el usuario ingresa una letra, se verifica si esa letra
				#está en la palabra seleccionada y posteriormente se verifica si ya se ganó o perdió para salir del ciclo
				clear
				imprimeMono
				imprimeEncontradas
				printf "\n\n\t\t    \e[1;34m¿Con qué letra intentarás ahora?  \e[0m"
				read letra	
				buscaLetra	
				winOrLose
				if [ "$ganaste" == "1" ] || [ "$perdiste" == "1" ]; then
					break
				fi
			done

			letra=0
			#Verificación de si se ganó o perdió e impresión según sea el caso
			if [ $ganaste == 1 ]; then
				clear
				imrimeGanador
				imprimeEncontradas
				echo -e "\n\n\t\t\t\e[1;33m¡Felicidades! ¡Has ganado!"
			elif [ $perdiste == 1 ]; then
				clear
				imprimeMono
				imprimeEncontradas
				echo -e "\n\n\t\t\t\e[1;33m¡Oh, no! \e[1;31m¡Has perdido! :( "
				echo -e "\n\t\t\t\e[1;33mLa palabra era: '\e[1;32m$palabra\e[1;33m'\e[0m"
			fi
			echo -e "\e[1;31m\n\n\n\t      Presiona 'enter' para volver al menú principal."
			read
			;;
		2) ##Impresión en pantalla de las instrucciones de juego
			opc=0
			clear
			echo -e "\e[1;33m\n\n\t\t\t¿En serio no sabes jugar ahorcado?\n\n"
			echo -e "\e[1;32m     El objetivo del juego es adivinar una palabra que es seleccionada al azar"
			echo -e "     al principio del juego. Para ello, debes presionar una letra que creas"
			echo -e "     que pertenezca a la palabra, seguida de un 'enter'.\n"
			echo -e "     Cuentas con siete intentos para lograr adivinar la palabra. Si no lo"
			echo -e "     logras, habrás matado a un inocente hombresillo de ASCII :(.\n"
			echo -e "     El diccionario por defecto trae únicamente verbos, sustantivos y"
			echo -e "     adjetivos, todos con minúsculas y sin acentos, pero con la opción"
			echo -e "     'Agregar palabra al diccionario', ¡puedes agregar las palabras que tú"
			echo -e "     quieras para jugar después!\n"
			echo -e "     ¿Qué esperas? ¡Ve al salvar al hombrecillo de ASCII!\n"
			echo -e "\e[1;31m\n\t\tPresiona 'enter' para volver al menú principal."
			read
			;;
		3) #Se despliega el menú agregar palabras al diccionario
			clear
			echo -e "\n\n\n\n\t\e[1;33m  Teclea la palabra que deseas agregar seguida de un 'enter'\e[1;34m\n"
			printf "\t\t\t\t"
			read addword
			echo "$addword" >> "diccionario.txt"
			echo -e "\n\n\t     \e[1;32mLa palabra \e[1;31m$addword \e[1;32mse agregó con éxito al diccionario."
			echo -e "\e[1;31m\n\n\n\n\t\tPresiona 'enter' para volver al menú principal."
			read

			opc=0
			;;
		4) #Salir del juego
			opc=0
			salir=1
			;;
		*)
			opc=0
			;;
	esac
done