#!/bin/bash

# NOTA: read espera a que escribas algo y pulses Intro, y lo guarda en
#       la variable indicada al final.
#       -p "texto" muestra ese texto antes de esperar (el «prompt»).
#       -r hace que la barra \ se guarde tal cual (buena costumbre).
read -r -p "Nombre de usuario: " usuario
read -r -p "Departamento: " departamento

# NOTA: -s (silencioso) hace que lo que escribes NO aparezca en pantalla.
read -r -s -p "Contraseña: " clave

# NOTA: con -s, al pulsar Intro tampoco se ve el salto de línea.
#       Este echo vacío lo añade para que el resumen empiece en otra línea.
echo
