#!/bin/bash

# CORREGIDO (4): sin números no se puede calcular la media.
if [ $# -eq 0 ]; then
    echo "Uso: $0 NUMERO..." >&2
    exit 1
fi

suma=0

# CORREGIDO (3): "$@" entre comillas = todos los argumentos, cada uno
#                por separado.
for numero in "$@"; do
    # CORREGIDO (2): las sumas se hacen con $(( )).
    suma=$((suma + numero))
done

# NOTA: $# es cuántos números se han recibido. La división es ENTERA.
media=$((suma / $#))

echo "Números: $#"
# CORREGIDO (1): la variable se llama suma, no sum.
echo "Suma:    $suma"
echo "Media:   $media"

exit 0
# --------------------------------------------------------------
# EJEMPLOS DE EJECUCIÓN
#
#   $ ./media.sh 4 6 8
#   Números: 3
#   Suma:    18
#   Media:   6
#
#   $ ./media.sh; echo $?
#   Uso: ./media.sh NUMERO...
#   1
#
#   $ shellcheck media.sh        (no muestra nada: sin avisos)
# --------------------------------------------------------------
