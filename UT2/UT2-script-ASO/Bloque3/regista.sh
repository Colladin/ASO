#!/bin/bash

# Fichero donde se guardan los mensajes.
# NOTA: $HOME es una variable de entorno con tu carpeta personal
#       (/home/ana). Se usa $HOME y no ~ porque ~ no se expande
#       dentro de comillas.
fichero_registro="$HOME/ut2/ejercicios/registro.log"

# Fecha y hora con el formato 2026-10-20 09:20:13
# NOTA: %Y año, %m mes, %d día, %H hora, %M minutos, %S segundos.
fecha_hora=$(date '+%Y-%m-%d %H:%M:%S')

# NOTA: $* junta todos los argumentos en un solo texto. Así el mensaje
#       funciona tanto con comillas como sin ellas.
mensaje="$*"
