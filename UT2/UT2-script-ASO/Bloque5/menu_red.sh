#!/bin/bash

# Mostrar el menú.
echo "1) Direcciones IP"
echo "2) Puerta de enlace"
echo "3) Servidores DNS"
echo "4) Probar conexión a Internet"

# Pedir la opción.
read -r -p "Elige una opción: " opcion

# NOTA: case compara el valor de la variable con cada opción, de arriba
#       abajo, y ejecuta las órdenes de la primera que coincide.
#       Cada opción termina con ;; y el bloque case termina con esac.
case "$opcion" in
    1)
        # -br = formato breve: una línea por interfaz.
        ip -br address
        ;;
    2)
        # La puerta de enlace es la ruta «default».
        ip route | grep default
        ;;
    3)
        resolvectl status | grep "DNS Servers"
        ;;
    4)
        # NOTA: ping -c 2 envía solo 2 paquetes. &> /dev/null oculta su
        #       salida: solo nos interesa si ha funcionado (código 0) o no.
        if ping -c 2 8.8.8.8 &> /dev/null; then
            echo "Hay conexión"
        else
            echo "Sin conexión"
        fi
        ;;
    *)
        # NOTA: * coincide con CUALQUIER otro valor. Va siempre la última.
        echo "Error: opción no válida: $opcion" >&2
        exit 1
        ;;
esac

exit 0

# --------------------------------------------------------------
# EJEMPLOS DE EJECUCIÓN
#
#   $ ./menu_red.sh
#   1) Direcciones IP
#   2) Puerta de enlace
#   3) Servidores DNS
#   4) Probar conexión a Internet
#   Elige una opción: 2
#   default via 192.168.1.1 dev ens33 proto static
#
#   $ ./menu_red.sh
#   (...)
#   Elige una opción: 4
#   Hay conexión
#
#   $ ./menu_red.sh; echo $?
#   (...)
#   Elige una opción: 7
#   Error: opción no válida: 7
#   1
# --------------------------------------------------------------
