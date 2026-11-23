#!/bin/bash
#cabecera
#comprobacion

if [ $# -eq 0 ]; then
    echo "Uso: $0 USUARIO1 USUARIO2 ...]" >&2
    exit 2
fi

existen=0

for usuario in "$@"; do
    if id "$usuario" &> /dev/null; then
        echo "[OK] $usuario existe"
        existen=$((existen + 1))
    else
        echo "[FALTA] $usuario no existe"
    fi
done

echo "Existen $existen de $# usuarios"

if [ $existen -eq $# ]; then
    exit 0
else
    exit 1
fi
