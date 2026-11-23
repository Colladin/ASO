#!/bin/bash

# Comprobar que se ha recibido un nombre de usuario.
if [ $# -ne 1 ]; then
    echo "Uso: $0 USUARIO" >&2
    exit 1
fi

usuario=$1

# ¿Existe el usuario?
# NOTA: aquí la condición del if NO es [ ], sino un comando: id.
#       if mira el CÓDIGO DE SALIDA del comando: si es 0 (id ha encontrado
#       al usuario), se cumple; si es otro número, no se cumple.
# NOTA: &> /dev/null tira a la «papelera» todo lo que id muestra (salida y
#       errores): solo nos interesa su código de salida.
if id "$usuario" &> /dev/null; then
    echo "El usuario $usuario existe"
else
    echo "El usuario $usuario no existe" >&2
    exit 2
fi

# ¿Pertenece al grupo sudo?
# NOTA: id -nG usuario muestra los NOMBRES de sus grupos en una línea,
#       por ejemplo «ana adm sudo».
#       grep -q busca sin mostrar nada (q = quiet, silencioso): solo
#       devuelve el código 0 si lo encuentra.
#       -w busca la palabra completa: así «sudoers» no contaría como «sudo».
if id -nG "$usuario" | grep -qw sudo; then
    echo "Pertenece al grupo sudo: puede administrar el sistema"
else
    echo "No pertenece al grupo sudo: no es administrador"
fi

exit 0

# --------------------------------------------------------------
# EJEMPLOS DE EJECUCIÓN
#
#   $ ./comprueba_usuario.sh ana
#   El usuario ana existe
#   Pertenece al grupo sudo: puede administrar el sistema
#
#   $ ./comprueba_usuario.sh root
#   El usuario root existe
#   No pertenece al grupo sudo: no es administrador
# NOTA: root no necesita estar en el grupo sudo: ya es el administrador.
