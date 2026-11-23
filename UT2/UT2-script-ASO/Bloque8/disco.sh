#!/bin/bash

# El umbral se puede cambiar sin editar el script: cada servidor puede
# necesitar un margen distinto.
umbral=${1:-80}

# Necesitamos el uso como un número entero para poder compararlo con -ge.
# NOTA: df --output=pcent / muestra dos líneas: el título «Use%» y el
#       porcentaje, por ejemplo « 37%».
#       tail -n 1 se queda con la última línea (quita el título).
#       tr -dc '0-9' borra todo lo que NO sea una cifra (el espacio y el %).
uso_disco=$(df --output=pcent / | tail -n 1 | tr -dc '0-9')
# RESULTADO: uso_disco vale, por ejemplo, «37»

if [ "$uso_disco" -ge "$umbral" ]; then
    echo "AVISO: el disco raíz está al ${uso_disco} % (umbral: ${umbral} %)"
    # El código 1 permite que cron u otro script detecten el problema
    # sin tener que leer el mensaje.
    exit 1
else
    echo "OK: el disco raíz está al ${uso_disco} % (umbral: ${umbral} %)"
    exit 0
fi

# --------------------------------------------------------------
# EJEMPLOS DE EJECUCIÓN
#
#   $ ./disco.sh; echo $?
#   OK: el disco raíz está al 37 % (umbral: 80 %)
#   0
#
#   $ ./disco.sh 30; echo $?
#   AVISO: el disco raíz está al 37 % (umbral: 30 %)
#   1
#
# NOTA: compara este script con el original (alumnado/disco.sh). Los
#       comentarios del original repiten QUÉ hace cada línea («si x es
#       mayor o igual que 80»). Los buenos comentarios explican POR QUÉ
#       («el código 1 permite que cron detecte el problema»).
#       Las líneas marcadas con NOTA y RESULTADO son explicaciones para
#       estudiar: en un script real no se pondrían.
# --------------------------------------------------------------
