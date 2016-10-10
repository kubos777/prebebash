#!/bin/bash

declare -A board
declare -A rotaBoard
nombre=0
puntos=0
ganaste=0
perdiste=0

function clearBoard()
{
	board[0,0]='----'
	board[0,1]='----'
	board[0,2]='----'
	board[0,3]='----'
	board[1,0]='----'
	board[1,1]='----'
	board[1,2]='----'
	board[1,3]='----'
	board[2,0]='----'
	board[2,1]='----'
	board[2,2]='----'
	board[2,3]='----'
	board[3,0]='----'
	board[3,1]='----'
	board[3,2]='----'
	board[3,3]='----'
}

function printBoard()
{
	clear
	echo -e "\e[1;37m\n\n\t\t\t\tMovimientos: "$puntos"\n\n"
	echo -e "\t\t    \e[0;42m\t\t\t\t\t\e[0m"
	echo -e "\t\t    \e[0;42m\t\t\t\t\t\e[0m"
	echo -e "\t\t    \e[0;42m\t\e[1;30m"${board[0,0]}"\t"${board[0,1]}"\t"${board[0,2]}"\t"${board[0,3]}"\t\e[0m"
	echo -e "\t\t    \e[0;42m\t\t\t\t\t\e[0m"
	echo -e "\t\t    \e[0;42m\t\t\t\t\t\e[0m"
	echo -e "\t\t    \e[0;42m\t\e[1;30m"${board[1,0]}"\t"${board[1,1]}"\t"${board[1,2]}"\t"${board[1,3]}"\t\e[0m"
	echo -e "\t\t    \e[0;42m\t\t\t\t\t\e[0m"
	echo -e "\t\t    \e[0;42m\t\t\t\t\t\e[0m"
	echo -e "\t\t    \e[0;42m\t\e[1;30m"${board[2,0]}"\t"${board[2,1]}"\t"${board[2,2]}"\t"${board[2,3]}"\t\e[0m"
	echo -e "\t\t    \e[0;42m\t\t\t\t\t\e[0m"
	echo -e "\t\t    \e[0;42m\t\t\t\t\t\e[0m"
	echo -e "\t\t    \e[0;42m\t\e[1;30m"${board[3,0]}"\t"${board[3,1]}"\t"${board[3,2]}"\t"${board[3,3]}"\t\e[0m"
	echo -e "\t\t    \e[0;42m\t\t\t\t\t\e[0m"
	echo -e "\t\t    \e[0;42m\t\t\t\t\t\e[0m"
}

function addElement()
{
	while :; do
		fila=$((RANDOM % 4))
		colu=$((RANDOM % 4))
		if [ ${board[$fila,$colu]} = '----' ]; then
			board[$fila,$colu]=2
			break
		fi
	done
}

function moveElements()
{
	k=0
	for i in {0..3}; do
		for j in {0..3}; do
			if [[ ${board[$i,$j]} != "----" ]]; then
				k=$i
				while [ $k -ge 0 ]; do
					if [[ ${board[$k,$j]} == '----' ]]; then 
						board[$k,$j]=${board[$i,$j]}
						board[$i,$j]='----'
					elif [[ ${board[$k,$j]} == ${board[$i,$j]} && $k != $i ]]; then
						let board[$k,$j]=${board[$k,$j]}+${board[$i,$j]}
						board[$i,$j]='----'
					fi								
					let k=$k-1
				done
				k=0
			fi
		done
	done
}

function yourMove()
{
	read move

	case "$move" in 
		w)
			moveElements
			addElement
			;;
		a)
			rotar90
			moveElements
			rotar90
			rotar90
			rotar90
			addElement
			;;
		s)
			rotar90
			rotar90
			moveElements
			rotar90
			rotar90
			addElement
			;;	
		d)
			rotar90
			rotar90
			rotar90
			moveElements
			rotar90
			addElement
			;;
		*)
		;;
	esac
			
}

function rotar90()
{
	rotaBoard[0,0]=${board[3,0]}
	rotaBoard[0,1]=${board[2,0]}
	rotaBoard[0,2]=${board[1,0]}
	rotaBoard[0,3]=${board[0,0]}
	rotaBoard[1,0]=${board[3,1]}
	rotaBoard[1,1]=${board[2,1]}
	rotaBoard[1,2]=${board[1,1]}
	rotaBoard[1,3]=${board[0,1]}
	rotaBoard[2,0]=${board[3,2]}
	rotaBoard[2,1]=${board[2,2]}
	rotaBoard[2,2]=${board[1,2]}
	rotaBoard[2,3]=${board[0,2]}
	rotaBoard[3,0]=${board[3,3]}
	rotaBoard[3,1]=${board[2,3]}
	rotaBoard[3,2]=${board[1,3]}
	rotaBoard[3,3]=${board[0,3]}

	board[0,0]=${rotaBoard[0,0]}
	board[0,1]=${rotaBoard[0,1]}
	board[0,2]=${rotaBoard[0,2]}
	board[0,3]=${rotaBoard[0,3]}
	board[1,0]=${rotaBoard[1,0]}
	board[1,1]=${rotaBoard[1,1]}
	board[1,2]=${rotaBoard[1,2]}
	board[1,3]=${rotaBoard[1,3]}
	board[2,0]=${rotaBoard[2,0]}
	board[2,1]=${rotaBoard[2,1]}
	board[2,2]=${rotaBoard[2,2]}
	board[2,3]=${rotaBoard[2,3]}
	board[3,0]=${rotaBoard[3,0]}
	board[3,1]=${rotaBoard[3,1]}
	board[3,2]=${rotaBoard[3,2]}
	board[3,3]=${rotaBoard[3,3]}
}

function isGameLost()
{
	fichasMalas=0
	for i in {0..3}; do
		for j in {0..3}; do
			let arriba=$i+1
			let abajo=$i-1
			let dere=$j+1
			let izq=$j+1
			if [ "${board[$arriba,$j]}" != "----" ] && [ "${board[$arriba,$j]}" != "${board[$i,$j]}" ] && [ "${board[abajo,$j]}" != "----" ] && [ "${board[$abajo,$j]}" != "${board[$i,$j]}" ] && [ "${board[$i,$dere]}" != "----" ] && [ "${board[$i,$dere]}" != "${board[$i,$j]}" ] && [ "${board[$i,$izq]}" != "----" ] && [ "${board[$i,$izq]}" != "${board[$i,$j]}" ];then
				let fichasMalas=$fichasMalas+1
				if [ "$fichasMalas" == "16" ]; then
					perdiste=1
				fi
			fi
		done
	done
}

function isGameWon()
{
	for i in {0..3}; do
		for j in {0..3}; do
			if [ ${board[$i,$j]} == 4096 ]; then
				ganaste=1
			fi
		done
	done
}	

function validaHighscores()
{
	encontrado=0
	for f in $( ls ); do
		if [ "$f" == "highscores.txt" ]; then
			encontrado=1
			break;
		fi
	done
	if [ "$encontrado" == "0" ]; then
		echo -e "\e[1;33m\n\t\t\tHIGHSCORES DE 4096:\n" >> "highscores.txt"
	fi
}

function highscore()
{
	echo -e "\e[1;32m\n\t\t\t    ¿Cuál es tu nombre?"
	read nombre
	echo -e "\t-\e[1;37m $nombre \e[1;35m alzanzó la casilla 4096 en \e[1;37m$puntos\e[1;35m movimientos." >> "highscores.txt"
	echo -e "\n\t\t¡Has sido agregado a la lista de highscores!"
}

salir=0
opc=0

validaHighscores
while [ "$salir" == 0 ]; do
	case "$opc" in
		0)
			clear
			echo -e "\e[1;33m \n\n\n\t\t         B I E N V E N I D O   A:\n"
			echo -e "\e[1;31m\t\t" ' __   __      ______   ______   ______     '
			echo -e "\t\t" '/__/\/__/\   /_____/\ /_____/\ /_____/\    '
			echo -e "\t\t" '\  \ \: \ \__\:::_ \ \\\:::_:\ \\\:::__\/    '
			echo -e "\t\t" ' \::\_\::\/_/\\\:\ \ \ \\\:\_\:\ \\\:\ \____  '
			echo -e "\t\t" '  \_:::   __\/ \:\ \ \ \\\::__:\ \\\::__::/\ '
			echo -e "\t\t" '       \::\ \   \:\_\ \ \    \ \ \\\:\_\:\ \'
			echo -e "\t\t" '        \__\/    \_____\/     \_\/ \_____\/'
			echo -e "\e[1;33m\n\n\t\t    Selecciona una opción \e[0;33m(número+'enter')\e[1;33m:\e[1;37m\n\n\t\t\t      1) ¡Empezar a jugar!\n\t\t\t      2) Instrucciones\n\t\t\t      3) Ver highscores\n\t\t\t      4) Salir\e[0m"
			read opc
			;;
		1)
			clear
			opc=0
			ganaste=0
			perdiste=0
			puntos=0
			clearBoard
			addElement

			while :;do
				printBoard
				isGameWon
				if [ "$ganaste" == 1 ]; then
					break
				fi
				isGameLost
				if [ "$perdiste" == 1 ]; then
					break
				fi
				yourMove
				let puntos=$puntos+1
			done

			if [ $ganaste == 1 ]; then
				echo -e "\n\n\t\t\t\e[1;33m¡Felicidades! ¡Has ganado! \n\n\t\t      Lo lograste en \e[1;31m"$puntos"\e[1;33m movimientos."
				highscore
			elif [ $perdiste == 1 ]; then
				echo -e "\n\n\t\t\t¡Oh, no! ¡Has perdido! :( "
			fi
			echo -e "\e[1;31m\n\t       Presiona 'enter' para volver al menú principal."
			read
			;;
		2)
			clear
			opc=0
			echo -e "\e[1;33m\n\t\t\t¡Es muy sencillo empezar a jugar!\n\n"
			echo -e "\e[1;32m     ¿Has jugado el famoso juego 2048? ¡Pues éste es mejor porque fue hecho"
			echo -e "     por prebecarios de la generación #33 del PROTECO de la FI de la UNAM!\n"
			echo -e "     El objetivo del juego es lograr tener la casilla con el número '4096'"
			echo -e "     en el tablero con el menor número de movimientos posibles. Para ello,"
			echo -e "     deberás mover las casillas con las teclas 'w', 'a', 's' y 'd' (que co-"
			echo -e "     rresponden a arriba, izquierda, abajo y derecha respectivamente)"
			echo -e "     seguidas de un enter.\n"
			echo -e "     Cada vez que hagas un movimiento, TODAS las casillas en el tablero se"
			echo -e "     moverán en esa dirección y se agregará el valor de '2' a una casilla al"
			echo -e "     al azar en el tablero. Debes mover las casillas intentando unir aquellas"
			echo -e "     con el mismo valor, ¡pero ojo!, sólo se pueden unir casillas que están"
			echo -e "     en los bordes del tablero con casillas consecutivas a ellas.\n"
			echo -e "     Tal vez platicado suena difícil, pero es bastante sencillo. ¡Inténtalo!\n"
			echo -e "\e[1;31m\n\t\tPresiona 'enter' para volver al menú principal.\e[0m"
			read
			;;
		3) 
			clear
			opc=0
			cat highscores.txt
			echo -e "\e[1;31m\n\n\tPresiona 'enter' para volver al menú principal."
			read
			;;
		4)
			salir=1
			;;
		*)
			opc=0
			;;
	esac
done