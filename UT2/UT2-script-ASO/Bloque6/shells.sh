#!/bin/bash

# Tres contadores, todos a 0 ANTES del bucle.
con_bash=0
sin_inicio=0
otras=0

# NOTA: cada línea de /etc/passwd tiene 7 campos separados por «:», por ejemplo:
#       ana:x:1000:1000:Ana López:/home/ana:/bin/bash
#
# NOTA: while read lee el fichero LÍNEA A LÍNEA (el fichero entra por
#       «< /etc/passwd», en la última línea del bucle).
#       IFS=: indica que los campos están separados por «:».
#       read reparte los 7 campos, por orden, en las 7 variables.
#       Aunque solo usamos «shell», ponemos nombre a todos para que se
#       entienda qué es cada campo.
# shellcheck disable=SC2034
# NOTA: la línea anterior evita que ShellCheck avise de que hay
#       variables que no se usan (usuario, clave, uid…). Es intencionado.
while IFS=: read -r usuario clave uid gid descripcion directorio shell; do
    # NOTA: case compara la shell con cada patrón. El símbolo | significa
    #       «o»: la primera opción vale para /bin/bash O /usr/bin/bash.
    case "$shell" in
        /bin/bash|/usr/bin/bash)
            con_bash=$((con_bash + 1))
            ;;
        /usr/sbin/nologin|/sbin/nologin|/bin/false|/usr/bin/false)
            sin_inicio=$((sin_inicio + 1))
            ;;
        *)
            otras=$((otras + 1))
            ;;
    esac
done < /etc/passwd

echo "Cuentas con Bash:          $con_bash"
echo "Cuentas sin inicio sesión: $sin_inicio"
echo "Cuentas con otra shell:    $otras"

# --------------------------------------------------------------
# EJEMPLO DE EJECUCIÓN
#   $ ./shells.sh
#   Cuentas con Bash:          2
#   Cuentas sin inicio sesión: 30
#   Cuentas con otra shell:    1
#
#   Comprobación:
#   $ grep -c "/bin/bash$" /etc/passwd
#   2
# NOTA: la cuenta «otra shell» suele ser sync (/bin/sync).
# --------------------------------------------------------------

# --------------------------------------------------------------
# VERSIÓN CON TUBERÍA (INCORRECTA, solo para comparar)
#
#   cat /etc/passwd | while IFS=: read -r usuario clave uid gid descripcion directorio shell; do
#       ...
#   done
#
# RESULTADO:
#   Cuentas con Bash:          0
#   Cuentas sin inicio sesión: 0
#   Cuentas con otra shell:    0
#
# NOTA: cada parte de una tubería se ejecuta en un PROCESO APARTE (una
#       copia de la shell). El bucle suma en su copia de los contadores,
#       pero cuando la tubería termina esa copia desaparece. Los echo del
#       final usan los contadores del script, que siguen valiendo 0.
#       Por eso la versión correcta lee el fichero con «done < /etc/passwd».
# --------------------------------------------------------------
