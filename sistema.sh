#! /bin/bash

despliega_sistema() {
    echo "Hostname: " $(hostname)
    echo "Sistema operativo: " $(uname -a)
    echo "Versión del sistema: " $(uname -v)
    echo "Procesador: " $(uname -p)
    echo "RAM (MB): " $(free -m | tail -n 2 | head -n 1)
    echo "Tamaño de la particion principal: " $(df -h | grep '/$')
}

info_usuario () {
    echo "Información del usuario: " $(w | grep "$1")
}

SALIR=0
OPCION=0
while [ $SALIR -eq 0 ]; do
    echo "1) Usuarios conectados."
    echo "2) Qué está haciendo un usuario en específico."
    echo "3) Características del sistema."
    echo "4) Tiempo del sistema."
    echo "5) Volver."
    read OPCION
    case $OPCION in
	1)
	    echo "Usuarios conectados: "
	    echo `who`;;
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
	    info_usuario $USUARIO;;
	3)
	    despliega_sistema ;;
	4)
	    echo $(uptime);;
	5)
	    SALIR=1;;
	*)
	    echo "Opción incorrecta";;
    esac
done
