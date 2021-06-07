
obten_archivo() {
    if [ $1 = "-" ]; then
	TYPE="Archivo regular"
    elif [ $1 = "d" ]; then
	TYPE="Directorio"
    elif [ $1 = "c" ]; then
	TYPE="Caracter"
    elif [ $1 = "b" ]; then
	TYPE="Bloque"
    else
	TYPE="Socket"
    fi
}

imprime_permisos() {
    PERMS=""
    READ=$(ls -al $1 | cut -b $2)
    NEXT=$(($2+1))
    NNEXT=$(($2+2))
    if [ $READ != "-" ]; then
	PERMS+="LECTURA "
    fi
    ESC=$(ls -al $1 | cut -b $NEXT)
    if [ $ESC != "-" ]; then
	PERMS+="ESCRITURA "
    fi
    EJE=$(ls -al $1 | cut -b $NNEXT)
    if [ $EJE != "-" ]; then
	PERMS+="EJECUTABLE "
    fi
}

imprime_info() {
    echo "Nombre: " $1
    echo "i-nodo: " $(ls -i $1 | tr -d "$1")
    ARCH=$(ls -al $1 | cut -b 1)
    echo "Dueño: " $(stat -c %U $1)
    echo "Tamaño: " $(stat -c %s $1) " bytes"
    obten_archivo $ARCH
    echo "Tipo de archivo: " $TYPE
    echo "Fecha de modificación: " $(stat -c %y $1 | cut -b -19)
    imprime_permisos $1 2
    echo "Permisos para el dueño: " $PERMS
    imprime_permisos $1 5
    echo "Permisos para el grupo: " $PERMS
    imprime_permisos $1 8
    echo "Permisos para otros: " $PERMS
}


SALIR=0
OPCION=0
while [ $SALIR -eq 0 ]; do
    echo "1) Mostrar archivo."
    echo "2) Atributos de archivos."
    echo "3) Listar directorios."
    echo "4) Volver."
    read OPCION
    case $OPCION in
	1)
	    FILE=""
	    echo "Escriba el nombre del archivo"
	    read FILE
	    if [ -e $FILE -a ! -d $FILE ]; then
		cat $FILE | less
	    else
		if [ ! -e $FILE ]; then
		    echo "El archivo no existe"
		else
		    echo "El archivo es un directorio"
		fi
	    fi;;
	2)
	    FILE=""
	    echo "Escriba el nombre del archivo"
	    read FILE
	    if [ -e $FILE ]; then
		imprime_info $FILE
	    else
		echo "El archivo no existe"
	    fi;;
	3)
	    DIR=""
	    echo "Escriba el nombre del directorio"
	    read DIR
	    if [ -d $DIR ]; then
	        ls $DIR;
	    else
		echo "El directorio no existe"
	    fi;;
	4)
	    SALIR=1;;
	*)
	    echo "Opción equivocada";;
    esac
done
