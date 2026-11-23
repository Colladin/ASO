#!/bin/bash

equipo=${1:-8.8.8.8}
maximo_intentos=5
intento=1

# NOTA: until repite el bucle HASTA QUE la condición se cumpla, es decir,
#       mientras ping falle. Es lo contrario de while.
# NOTA: ping -c 1 envía un solo paquete; -W 1 espera como mucho 1 segundo
#       la respuesta. &> /dev/null oculta lo que muestra: solo nos
#       interesa si ha respondido (código 0) o no.
until ping -c 1 -W 1 "$equipo" &> /dev/null; do
    echo "Intento $intento: $equipo no responde"

    # Si ya hemos llegado al máximo, nos rendimos.
    # NOTA: -ge significa «mayor o igual que».
    if [ "$intento" -ge "$maximo_intentos" ]; then
        echo "Error: $equipo no responde tras $maximo_intentos intentos" >&2
        exit 1
    fi

    intento=$((intento + 1))
    # Esperar 1 segundo antes de volver a probar.
    sleep 1
done

echo "$equipo responde (intento $intento)"
exit 0

# --------------------------------------------------------------
# EJEMPLOS DE EJECUCIÓN
#
#   $ ./espera_red.sh 192.168.1.1
#   192.168.1.1 responde (intento 1)
#
#   $ ./espera_red.sh 192.168.1.250; echo $?
#   Intento 1: 192.168.1.250 no responde
#   Intento 2: 192.168.1.250 no responde
#   Intento 3: 192.168.1.250 no responde
#   Intento 4: 192.168.1.250 no responde
#   Intento 5: 192.168.1.250 no responde
#   Error: 192.168.1.250 no responde tras 5 intentos
#   1
# --------------------------------------------------------------
