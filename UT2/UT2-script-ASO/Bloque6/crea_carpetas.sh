#!/bin/bash

# Cuántas carpetas crear: el primer argumento o, si no hay, 5.
numero=${1:-5}

# Carpeta donde se crean.
carpeta_base="$HOME/ut2/pruebas"

# NOTA: seq 1 5 muestra los números del 1 al 5, uno por línea.
#       $(seq 1 "$numero") convierte esa salida en la lista que
#       recorre el for: 1 2 3 4 5.
for i in $(seq 1 "$numero"); do
    # NOTA: printf "alumno%02d" escribe el número con 2 cifras, rellenando
    #       con ceros a la izquierda: 1 → alumno01, 12 → alumno12.
    nombre_carpeta=$(printf "alumno%02d" "$i")

    # NOTA: -p crea también las carpetas intermedias (pruebas) si no
    #       existen, y no da error si la carpeta ya existe.
    mkdir -p "$carpeta_base/$nombre_carpeta"
done

echo "Se han creado $numero carpetas en $carpeta_base:"
ls "$carpeta_base"

# --------------------------------------------------------------
# EJEMPLOS DE EJECUCIÓN
#
#   $ ./crea_carpetas.sh 3
#   Se han creado 3 carpetas en /home/ana/ut2/pruebas:
#   alumno01  alumno02  alumno03
#
#   $ ./crea_carpetas.sh 12
#   Se han creado 12 carpetas en /home/ana/ut2/pruebas:
#   alumno01  alumno03  alumno05  alumno07  alumno09  alumno11
#   alumno02  alumno04  alumno06  alumno08  alumno10  alumno12
#
#   $ rm -r ~/ut2/pruebas        (para borrarla al terminar)
# --------------------------------------------------------------
