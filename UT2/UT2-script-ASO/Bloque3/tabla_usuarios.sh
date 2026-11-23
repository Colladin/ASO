# !/bin/bash

# NOTA: todas las filas usan el mismo formato de printf:
#       %-12s = texto en 12 posiciones, alineado a la IZQUIERDA (por el -).
#       %8s   = texto en 8 posiciones, alineado a la DERECHA (sin -).
#       %s    = texto sin ancho fijo.
#       \n    = salto de línea (printf, a diferencia de echo, no lo pone solo).
#       Cada %s se sustituye, por orden, por los textos que van detrás.

# Títulos y línea de separación.
printf "%-12s %8s  %s\n" "USUARIO" "UID" "SHELL"
printf "%-12s %8s  %s\n" "------------" "--------" "-----------------"

# --- Tu cuenta ---
mi_usuario=$(whoami)
# NOTA: id -u usuario muestra el número de usuario (UID).
mi_uid=$(id -u "$mi_usuario")
# NOTA: getent passwd usuario muestra la línea de ese usuario en
#       /etc/passwd, con los campos separados por «:».
#       cut -d: -f7 se queda con el campo 7, que es la shell.
mi_shell=$(getent passwd "$mi_usuario" | cut -d: -f7)
printf "%-12s %8s  %s\n" "$mi_usuario" "$mi_uid" "$mi_shell"
# RESULTADO: ana              1000  /bin/bash

# --- root ---
uid_root=$(id -u root)
shell_root=$(getent passwd root | cut -d: -f7)
printf "%-12s %8s  %s\n" "root" "$uid_root" "$shell_root"
# RESULTADO: root                0  /bin/bash

# --- nobody ---
uid_nobody=$(id -u nobody)
shell_nobody=$(getent passwd nobody | cut -d: -f7)
printf "%-12s %8s  %s\n" "nobody" "$uid_nobody" "$shell_nobody"
# RESULTADO: nobody          65534  /usr/sbin/nologin

# --------------------------------------------------------------
# EJEMPLO DE EJECUCIÓN
#   $ ./tabla_usuarios.sh
#   USUARIO           UID  SHELL
#   ------------ --------  -----------------
#   ana              1000  /bin/bash
#   root                0  /bin/bash
#   nobody          65534  /usr/sbin/nologin
# --------------------------------------------------------------
