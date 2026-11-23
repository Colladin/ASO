#!/bin/bash

# Ruta que se revisa: el primer argumento o, si no hay, «.» (la carpeta actual).
ruta=${1:-.}

ficheros=0
directorios=0

# NOTA: "$ruta"/* es la lista de todo lo que hay dentro de la ruta.
#       El for la recorre con la variable elemento.
for elemento in "$ruta"/*; do
    if [ -f "$elemento" ]; then
        ficheros=$((ficheros + 1))
    # CORREGIDO: faltaba el ; antes de then.
    elif [ -d "$elemento" ]; then
        directorios=$((directorios + 1))
    fi
done

# CORREGIDO: faltaban las comillas de cierre.
echo "En $ruta hay $ficheros ficheros y $directorios directorios"

# --------------------------------------------------------------
# EJEMPLO DE EJECUCIÓN
#   $ bash -n contar.sh          (no muestra nada: sintaxis correcta)
#   $ ./contar.sh /etc
#   En /etc hay 98 ficheros y 107 directorios
# NOTA: en la versión original la variable se llamaba «e». Le hemos
#       puesto un nombre descriptivo; no cambia el funcionamiento.
# --------------------------------------------------------------
