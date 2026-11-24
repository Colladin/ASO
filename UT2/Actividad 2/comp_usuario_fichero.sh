#!/bin/bash
# Nombre:  comprueba_usuarios_fichero.sh
# Uso:     ./comprueba_usuarios_fichero.sh USUARIO1 [USUARIO2 ...]
#          ./comprueba_usuarios_fichero.sh -f FICHERO
# Qué hace: indica si existe cada usuario y cuántos existen en total.
#           Con -f, lee los usuarios de FICHERO (uno por línea).
# Salida:  0 si existen todos · 1 si falta alguno · 2 si no recibe usuarios
#          o no puede leer el fichero.

# Comprobar que llega al menos un argumento
if [ $# -eq 0 ]; then
    echo "Uso: $0 USUARIO1 [USUARIO2 ...] | -f FICHERO" >&2
    exit 2
fi

existen=0
total=0

if [ "$1" = "-f" ]; then
    # Ampliación: los usuarios se leen del fichero, uno por línea
    fichero=$2
    if [ $# -ne 2 ] || [ ! -r "$fichero" ]; then
        echo "Uso: $0 -f FICHERO (el fichero debe existir y poder leerse)" >&2
        exit 2
    fi
    while read -r usuario || [ -n "$usuario" ]; do
        if [ -z "$usuario" ]; then
            continue                    # salta las líneas vacías
        fi
        total=$((total + 1))
        if id "$usuario" &> /dev/null; then
            echo "[OK]    $usuario existe"
            existen=$((existen + 1))
        else
            echo "[FALTA] $usuario no existe"
        fi
    done < "$fichero"
else
    # Lo normal: los usuarios llegan como argumentos
    for usuario in "$@"; do
        total=$((total + 1))
        if id "$usuario" &> /dev/null; then
            echo "[OK]    $usuario existe"
            existen=$((existen + 1))
        else
            echo "[FALTA] $usuario no existe"
        fi
    done
fi

# Un fichero sin usuarios es como no recibir ninguno
if [ "$total" -eq 0 ]; then
    echo "No se ha recibido ningún usuario" >&2
    exit 2
fi

echo "Existen $existen de $total usuarios"

if [ "$existen" -eq "$total" ]; then
    exit 0
else
    exit 1
fi
