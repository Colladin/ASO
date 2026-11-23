#!/bin/bash

codigo=$1

echo "El script termina con el código $codigo"

# NOTA: exit termina el script en ese momento y devuelve el número
#       indicado. Quien lo ha ejecutado puede consultarlo con $?
#       Por convenio: 0 = todo ha ido bien; otro número = ha habido
#       algún problema (cada número puede indicar un problema distinto).
exit "$codigo"

# --------------------------------------------------------------
# EJEMPLOS DE EJECUCIÓN
#
#   $ ./salida.sh 0; echo $?
#   El script termina con el código 0
#   0
#
#   $ ./salida.sh 3; echo $?
#   El script termina con el código 3
#   3
# NOTA: echo $? muestra el código de salida del ÚLTIMO comando, en este
#       caso el script. Sirve para que otro script, cron o una persona
#       sepa si ha funcionado sin tener que leer los mensajes.
