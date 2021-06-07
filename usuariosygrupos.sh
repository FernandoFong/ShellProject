#! /bin/bash

imprime_info_usuario () {
    echo "Login: " $1
    echo "UID: " $(id -u $1)
    echo "GID: " $(id -g $1)
    echo "Grupo(s): " $(groups $1)
    echo "Comentario: " $(grep $1 /etc/passwd | cut -d : -f5)
    echo "Home: " $(grep $1 /etc/passwd | cut -d : -f6)
    echo "Shell: " $(grep $1 /etc/passwd | cut -d : -f7)
}

imprime_info_grupo () {
    echo "GID: " $(grep $1 /etc/group | cut -d : -f3)
    echo "Nombre: " $1
    echo "Grupo secundario: " $(groups $1 | cut -d ' ' -f2-)
}

SALIR=0
OPCION=0
while [ $SALIR -eq 0 ]; do
    echo "1) Mostrar la información de un usuario."
    echo "2) Mostrar la información de un grupo."
    echo "3) Número total de usuarios en el sistema y login."
    echo "4) Número total de grupos en el sistema y nombre."
    echo "5) Volver."
    read OPCION
    case $OPCION in
	1)
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
	    imprime_info_usuario $USUARIO;;
	2)
	    echo "Escriba el nombre del grupo"
	    NOMBRE=""
	    read NOMBRE
	    imprime_info_grupo $NOMBRE;;
	3)
	    echo "Usuarios: " `wc -l /etc/passwd | cut -d ' ' -f1`
	    echo "Nombres: " `cat /etc/passwd | cut -d : -f1`;;
	4)
	    echo "Grupos: "`wc -l /etc/group | cut -d ' ' -f1`
	    echo "Nombres: "`cat /etc/group | cut -d : -f1`;;
	5)
	    SALIR=1;;
	*)
	    echo "Opción inválida"
    esac
done

