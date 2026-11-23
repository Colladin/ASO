#!/bin/bash
echo "$(date +%T) Inicio de la copia" >> "$HOME/copias.log"
grep -v "^#" /etc/ssh/sshd_config | grep -v "^$" # config. sin comentarios ni 
líneas vacías
echo "Error: falta el nombre de usuario" >&2