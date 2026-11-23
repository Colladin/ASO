# !/bin/bash

# Contador de ficheros: empieza en 0, ANTES del bucle.
total=0

# NOTA: /var/log/*.log es un comodín: Bash lo sustituye por la lista de
#       ficheros de /var/log que terminan en .log. El for los recorre
#       uno a uno con la variable fichero.
for fichero in /var/log/*.log; do
    # NOTA: du -h muestra el tamaño en formato legible (4,0K, 1,2M…)
    #       seguido de un tabulador y el nombre del fichero.
    #       cut -f1 se queda con el primer campo: solo el tamaño.
    tamano=$(du -h "$fichero" | cut -f1)

    # NOTA: %-35s deja 35 posiciones para el nombre, así los tamaños
    #       quedan alineados en columna.
    printf "%-35s %s\n" "$fichero" "$tamano"

    total=$((total + 1))
done

echo "Ficheros .log: $total"

# --------------------------------------------------------------
# EJEMPLO DE EJECUCIÓN
#   $ ./logs.sh
#   /var/log/alternatives.log           4,0K
#   /var/log/apport.log                 4,0K
#   /var/log/auth.log                   36K
#   /var/log/cloud-init.log             108K
#   /var/log/dpkg.log                   412K
#   /var/log/kern.log                   88K
#   Ficheros .log: 6
# NOTA: la lista depende de lo instalado en cada máquina.
# --------------------------------------------------------------
