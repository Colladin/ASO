#!/bin/bash

# Tu usuario.
usuario=$(whoami)
# RESULTADO: usuario vale «ana»

# El nombre del equipo.
equipo=$(hostname)
# RESULTADO: equipo vale «SRVUBASO»

# La fecha y la hora con el formato 20/10/2026 a las 09:15
# NOTA: %d = día, %m = mes, %Y = año con 4 cifras, %H = hora, %M = minutos.
#       El texto «a las» se copia tal cual. Las comillas simples son