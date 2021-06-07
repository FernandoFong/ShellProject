
print_error() {
    RED='\033[0;31m'
    NC='\033[0M'
    printf "${RED}${1}\n ${NC}"
}

SALIR=0
OPCION=0
while [ $SALIR -eq 0 ]; do
    echo "1) Archivos."
    echo "2) Procesos. "
    echo "3) Usuarios y grupos."
    echo "4) Sistema."
    echo "5) Salir."
    read OPCION
    case $OPCION in
	1)
	    ./archivos.sh;;
	2)
	    ./procesos.sh;;
	3)
	    ./usuariosygrupos.sh;;
	4)
	    ./sistema.sh;;
	5)
	    echo "Hasta luego";
	    SALIR=1;;
	*)
	    echo "Opción equivocada";;
    esac
done
