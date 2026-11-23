#!/bin/bash

numero1=$1
numero2=$2

# NUEVO EN 5.4: comprobar el divisor ANTES de hacer ninguna cuenta.
# NOTA: -eq significa «es igual» para NÚMEROS. No se puede usar =,
#       que compara textos, ni ==.
if [ "$numero2" -eq 0 ]; then
    echo "Error: el segundo número no puede ser 0 (no se puede dividir entre 0)" >&2
    exit 1
fi

# NOTA: las variables guardan TEXTO. Para hacer cuentas hay que usar
#       $(( )). Dentro no hace falta poner $ delante de las variables.
#       Bash solo trabaja con números ENTEROS.
suma=$((numero1 + numero2))
resta=$((numero1 - numero2))
producto=$((numero1 * numero2))
# NOTA: / es la división ENTERA: 17 / 5 = 3 (se pierden los decimales).
division=$((numero1 / numero2))
# NOTA: % es el RESTO de la división entera: 17 % 5 = 2.
resto=$((numero1 % numero2))

# Porcentaje con dos decimales.
# NOTA: como $(( )) no admite decimales, usamos la calculadora bc.
#       echo le pasa la operación por una tubería y scale=2 indica que
#       queremos 2 decimales. Se multiplica por 100 ANTES de dividir.
porcentaje=$(echo "scale=2; $numero1 * 100 / $numero2" | bc)

echo "Suma:       $suma"
echo "Resta:      $resta"
echo "Producto:   $producto"
echo "División:   $division"
echo "Resto:      $resto"
echo "Porcentaje: $porcentaje %"

exit 0

# --------------------------------------------------------------
# EJEMPLOS DE EJECUCIÓN
#
#   $ ./calcula.sh 17 5
#   Suma:       22
#   Resta:      12
#   Producto:   85
#   División:   3
#   Resto:      2
                                                                                                                                                                                                                            1,1      Comienzo

