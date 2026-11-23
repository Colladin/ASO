#!/bin/bash

# 1. Comprobar que se ha recibido exactamente un argumento.
# NOTA: $# es el número de argumentos. -ne significa «no es igual» (en números).
if [ $# -ne 1 ]; then
    # NOTA: >&2 envía el mensaje a la salida de ERRORES (canal 2), que es
    #       donde deben ir los mensajes de error de un script.
    echo "Uso: $0 RUTA" >&2
    exit 1
fi

ruta=$1

# 2. Comprobar que la ruta existe.
# NOTA: -e es «existe». El ! delante le da la vuelta: «NO existe».
if [ ! -e "$ruta" ]; then
    echo "Error: $ruta no existe" >&2
    exit 2
fi

# 3. Decir qué tipo de ruta es.
# NOTA: -f = es un fichero normal; -d = es un directorio.
if [ -f "$ruta" ]; then
    # NOTA: stat -c %s muestra el tamaño del fichero en bytes.
    tamano=$(stat -c %s "$ruta")
    echo "$ruta es un fichero de $tamano bytes"
elif [ -d "$ruta" ]; then
    # NOTA: ls -A lista el contenido (también los ocultos, sin . ni ..),
    #       un elemento por línea al pasar por la tubería, y wc -l cuenta
    #       las líneas.
    # NOTA: ShellCheck da un aviso informativo (SC2012) y recomienda find,
    #       porque ls puede contar mal nombres de fichero muy raros (con
    #       saltos de línea). Para este ejercicio, ls es suficiente.
    # shellcheck disable=SC2012
    elementos=$(ls -A "$ruta" | wc -l)
    echo "$ruta es un directorio con $elementos elementos"
else
    # Por ejemplo, /dev/null es un «dispositivo», no un fichero normal.
    echo "$ruta existe, pero no es ni un fichero ni un directorio"
fi

# 4. Permisos que tiene sobre la ruta el usuario que ejecuta el script.
# NOTA: -r = se puede leer; -w = se puede modificar; -x = se puede ejecutar.
if [ -r "$ruta" ]; then
    echo "Lectura:     sí"
else
    echo "Lectura:     no"
fi

if [ -w "$ruta" ]; then
    echo "Escritura:   sí"
else
    echo "Escritura:   no"
fi

# NOTA: en un directorio, el permiso de ejecución significa poder ENTRAR en él.
if [ -x "$ruta" ]; then
    echo "Ejecución:   sí"
else
    echo "Ejecución:   no"
fi

exit 0

# --------------------------------------------------------------
# EJEMPLOS DE EJECUCIÓN (con un usuario normal, sin sudo)
#
#   $ ./tipo_ruta.sh /etc/hosts
#   /etc/hosts es un fichero de 228 bytes
#   Lectura:     sí
#   Escritura:   no
#   Ejecución:   no
#
#   $ ./tipo_ruta.sh /etc
#   /etc es un directorio con 205 elementos
#   Lectura:     sí
#   Escritura:   no
#   Ejecución:   sí
#
#   $ ./tipo_ruta.sh /dev/null
#   /dev/null existe, pero no es ni un fichero ni un directorio
#   Lectura:     sí
#   Escritura:   sí
#   Ejecución:   no
#
#   $ ./tipo_ruta.sh /etc/shadow
#   /etc/shadow es un fichero de 1022 bytes
#   Lectura:     no
#   Escritura:   no
#   Ejecución:   no
# NOTA: se puede ver el tamaño aunque no se pueda leer el contenido.
#
#   $ ./tipo_ruta.sh /no_existe; echo $?
#   Error: /no_existe no existe
#   2
#
#   $ ./tipo_ruta.sh; echo $?
#   Uso: ./tipo_ruta.sh RUTA
#   1
# --------------------------------------------------------------
