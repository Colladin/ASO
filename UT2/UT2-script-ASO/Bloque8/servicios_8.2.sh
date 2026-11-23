#!/bin/bash

# --- Ayuda ---
# NOTA: || significa «o»: se cumple si el primer argumento es -h O --help.
if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    echo "Uso: $0 [SERVICIO...]"
    echo "Muestra si cada servicio está activo y cuántos lo están."
    echo "Sin argumentos revisa ssh, cron, rsyslog y apache2."
    echo "Ejemplo: $0 ssh cron"
    exit 0
fi

# --- Lista de servicios por defecto ---
# Si no se indica ningún servicio, se usa la lista fija del ejercicio 6.1.
# NOTA: set -- ssh cron rsyslog apache2 SUSTITUYE los argumentos del
#       script por esas cuatro palabras, como si se hubieran escrito al
#       ejecutarlo. Desde aquí, $# vale 4 y "$@" es esa lista.
if [ $# -eq 0 ]; then
    set -- ssh cron rsyslog apache2
fi

activos=0

# NOTA: "$@" = todos los argumentos, cada uno por separado.
#       Son los que se han escrito al ejecutar o, si no había, la lista
#       por defecto.
for servicio in "$@"; do
    # systemctl is-active muestra «active», «inactive», «failed»…
    estado=$(systemctl is-active "$servicio")
    printf "%-10s %s\n" "$servicio" "$estado"

    if [ "$estado" = "active" ]; then
        activos=$((activos + 1))
    fi
done

# NOTA: $# es el número de servicios revisados (ya no es siempre 4).
echo "Servicios activos: $activos de $#"

# El código de salida indica si hay algún servicio parado, para que
# otro script o cron pueda comprobarlo.
if [ "$activos" -eq $# ]; then
    exit 0
else
    exit 1
fi 
# --------------------------------------------------------------
# EJEMPLOS DE EJECUCIÓN
#
#   $ ./servicios.sh; echo $?
#   ssh        active
#   cron       active
#   rsyslog    active
#   apache2    inactive
#   Servicios activos: 3 de 4
#   1
#
#   $ ./servicios.sh ssh cron; echo $?
#   ssh        active
#   cron       active
#   Servicios activos: 2 de 2
#   0
#
#   $ ./servicios.sh -h
#   Uso: ./servicios.sh [SERVICIO...]
#   Muestra si cada servicio está activo y cuántos lo están.
#   Sin argumentos revisa ssh, cron, rsyslog y apache2.
#   Ejemplo: ./servicios.sh ssh cron
# --------------------------------------------------------------
