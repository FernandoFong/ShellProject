#!/bin/bash

SALIR=0
OPCION=0
while [ $SALIR -eq 0 ]; do
    echo "1) Listar todos los procesos."
    echo "2) Procesos de usuario."
    echo "3) Listar un proceso por nombre."
    echo "4) Volver."
    read OPCION
    case $OPCION in
	1)
	    top;;
	2)
	    SELEC=0
	    OP2=0
	    while [ $SELEC -eq 0 ]; do
		echo "Desea escribir el nombre del usuario?"
		echo "1) Sí"
		echo "2) No"
		read OP2
		case $OP2 in
		    1)
			SELEC=1
			USUARIO=""
			echo "Escriba el nombre del usuario" 
			read USUARIO;;
		    2)
			SELEC=1
			USUARIO=`whoami`;;
		    *)
			echo "Escriba 1 o 2 nada más";;
		    esac
	    done
	    echo $(ps aux | grep "$USUARIO" | less);;
	3)
	    echo "Escriba el nombre del proceso"
	    NOMBRE=""
	    read NOMBRE
	    PID=`pidof $NOMBRE`
	    echo $(ps aux | grep "$NOMBRE");;
	4)
	    SALIR=1;;
	*)
	    echo "Opción equivocada";;
    esac
done
