# Contenido

- [Introducción](#introducción)
- [Requisitos](#requisitos)
- [1. Entorno de trabajo y primer script](#1-entorno-de-trabajo-y-primer-script)
  - [1.1 Comprobar el acceso por SSH](#11-comprobar-el-acceso-por-ssh)
  - [1.2 Definir el servidor en el fichero config](#12-definir-el-servidor-en-el-fichero-config)
  - [1.3 Instalar la extensión Remote - SSH](#13-instalar-la-extensión-remote---ssh)
  - [1.4 Conectarte a la máquina virtual](#14-conectarte-a-la-máquina-virtual)
  - [1.5 Preparar la carpeta de trabajo y las herramientas](#15-preparar-la-carpeta-de-trabajo-y-las-herramientas)
  - [1.6 Primer script](#16-primer-script)
  - [1.7 Formas de ejecutar un script](#17-formas-de-ejecutar-un-script)
  - [1.8 Copiar los scripts a tu repositorio](#18-copiar-los-scripts-a-tu-repositorio)
- [2. Variables, comillas y parámetros](#2-variables-comillas-y-parámetros)
  - [2.1 Asignar y usar variables](#21-asignar-y-usar-variables)
  - [2.2 Comillas: predice y comprueba](#22-comillas-predice-y-comprueba)
  - [2.3 Comillas y espacios](#23-comillas-y-espacios)
  - [2.4 Sustitución de comandos](#24-sustitución-de-comandos)
  - [2.5 Parámetros de posición](#25-parámetros-de-posición)
- [3. Entrada, salida y redirecciones](#3-entrada-salida-y-redirecciones)
  - [3.1 Tablas con printf](#31-tablas-con-printf)
  - [3.2 Pedir datos con read](#32-pedir-datos-con-read)
  - [3.3 Redirecciones](#33-redirecciones)
  - [3.4 Un registro de actividad](#34-un-registro-de-actividad)
- [4. Operaciones aritméticas y códigos de salida](#4-operaciones-aritméticas-y-códigos-de-salida)
  - [4.1 Calculadora](#41-calculadora)
  - [4.2 El error del contador](#42-el-error-del-contador)
  - [4.3 Códigos de salida](#43-códigos-de-salida)
  - [4.4 El código de salida de tus scripts](#44-el-código-de-salida-de-tus-scripts)
  - [4.5 Encadenar con && y \|\|](#45-encadenar-con--y-)
- [5. Condiciones](#5-condiciones)
  - [5.1 ¿Qué es esta ruta?](#51-qué-es-esta-ruta)
  - [5.2 ¿Existe y es administrador?](#52-existe-y-es-administrador)
  - [5.3 Menú con case](#53-menú-con-case)
  - [5.4 La trampa de \> en las condiciones](#54-la-trampa-de--en-las-condiciones)
- [6. Bucles](#6-bucles)
  - [6.1 Recorrer una lista](#61-recorrer-una-lista)
  - [6.2 Recorrer un rango](#62-recorrer-un-rango)
  - [6.3 Recorrer ficheros](#63-recorrer-ficheros)
  - [6.4 Leer un fichero línea a línea](#64-leer-un-fichero-línea-a-línea)
  - [6.5 Repetir hasta que funcione](#65-repetir-hasta-que-funcione)
- [7. Depuración](#7-depuración)
  - [7.1 Errores de sintaxis](#71-errores-de-sintaxis)
  - [7.2 Errores de ejecución y de lógica](#72-errores-de-ejecución-y-de-lógica)
  - [7.3 Finales de línea de Windows](#73-finales-de-línea-de-windows)
- [8. Documentación y repositorio](#8-documentación-y-repositorio)
  - [8.1 Comentarios útiles](#81-comentarios-útiles)
  - [8.2 Cabecera y ayuda](#82-cabecera-y-ayuda)
  - [8.3 README y entrega en el repositorio](#83-readme-y-entrega-en-el-repositorio)
- [9. Lista de autoevaluación](#9-lista-de-autoevaluación)
- [10. Qué subir a tu repositorio de documentación](#10-qué-subir-a-tu-repositorio-de-documentación)

> **💡 Ejercicios de clase, no calificados**
>
> Estos ejercicios no tienen nota. Sirven para que practiques cada estructura justo después de verla y compruebes que la entiendes. Al final tienes una lista de autoevaluación y una guía de lo que debes subir a tu repositorio de documentación.

# Introducción

En la UT1 te conectabas al servidor por SSH y escribías los comandos uno a uno. En esta unidad vas a escribir **scripts**: ficheros con comandos que se ejecutan siempre de la misma forma. Para trabajar con comodidad usarás **VS Code en tu equipo** conectado por SSH a la máquina virtual: escribes en tu equipo, pero el fichero se guarda y se ejecuta en el servidor.

Los ejercicios están organizados en ocho bloques, en el mismo orden que los apuntes.

En cada ejercicio, **escribe tú el código**: no copies y pegues desde este documento. Equivocarte con un espacio o unas comillas y ver el error es parte del aprendizaje.

# Requisitos

- Una máquina virtual **Ubuntu Server 26.04** en VMware, con SSH funcionando y **conexión a Internet** (la primera conexión de VS Code descarga un componente en la máquina virtual). Puedes reutilizar la de la UT1.

<!-- -->

- Tu equipo: **Linux Mint** en el aula o **Windows 10/11** en casa, con **Visual Studio Code** instalado.

- Tu **repositorio de documentación** de GitHub, clonado en tu equipo (no en la máquina virtual).

- Los ficheros contar.sh, media.sh y disco.sh, disponibles en Teams, para los bloques 7 y 8.

***Revisa que la máquina virtual tiene las configuraciones mínimas iniciales: IP fija, nombre «significativo», actualizaciones al día.***

# 1. Entorno de trabajo y primer script

Vas a preparar el entorno con el que trabajarás toda la unidad: VS Code en tu equipo, conectado por SSH a la máquina virtual. Salvo que se indique otra cosa, los comandos de los pasos 1.1 a 1.3 se ejecutan **en tu equipo** y el resto **en la terminal de VS Code**, que ya es una terminal de la máquina virtual.

## 1.1 Comprobar el acceso por SSH

Abre una terminal en tu equipo (en Windows, PowerShell) y comprueba que tienes el cliente SSH y que puedes entrar en la máquina virtual:

```bash
ssh -V
ssh tu_usuario@ip_de_la_mv
```

Si en la UT1 no configuraste el acceso con clave, hazlo ahora. Genera el par de claves (acepta la ruta por defecto) y copia la clave pública a la máquina virtual:

```bash
ssh-keygen -t ed25519
# En Linux Mint:
ssh-copy-id tu_usuario@ip_de_la_mv
# En Windows (PowerShell), en una sola línea:
type $env:USERPROFILE\.ssh\id_ed25519.pub | ssh tu_usuario@ip_de_la_mv "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys"
```

Comprueba que ahora entras sin que te pida la contraseña del usuario.

## 1.2 Definir el servidor en el fichero config

Crea (o edita) el fichero de configuración del cliente SSH de tu equipo:

```bash
# Linux Mint
nano ~/.ssh/config
# Windows (PowerShell)
notepad $env:USERPROFILE\.ssh\config
```

Añade este bloque con tus datos:

```bash
Host ubuntu-aso
HostName ip_de_la_mv
User tu_usuario
IdentityFile ~/.ssh/id_ed25519
```

Comprueba que funciona con ssh ubuntu-aso.

> **⚠ Atención**
>
> En Windows, el Bloc de notas puede guardar el fichero como config.txt. Comprueba con dir \$env:USERPROFILE\\ssh que se llama exactamente config, sin extensión.

## 1.3 Instalar la extensión Remote - SSH

En VS Code, abre el panel de extensiones (Ctrl + Mayús + X), busca **Remote - SSH** (de Microsoft) e instálala. Aparecerá un icono verde o azul en la esquina inferior izquierda.

## 1.4 Conectarte a la máquina virtual

1.  Pulsa F1 (o Ctrl + Mayús + P), escribe Remote-SSH y elige **Conectar al host…** (*Connect to Host…* si tienes VS Code en inglés). También puedes hacer clic en el icono \>\< de la esquina inferior izquierda.

<!-- -->

1.  Selecciona ubuntu-aso. Si pregunta por el sistema operativo del servidor, elige **Linux**.

2.  Espera a que termine la instalación del servidor de VS Code en la máquina virtual (solo la primera vez).

3.  Comprueba que en la esquina inferior izquierda aparece **SSH: ubuntu-aso**.

Abre la terminal integrada (menú Terminal, Nueva terminal) y ejecuta hostname, whoami y pwd. Anota el resultado: ¿es tu equipo o la máquina virtual?

> **💡 Si no conecta**
>
> Usa **Remote-SSH: Show Log** desde F1 para ver el error. Las causas más habituales son que la máquina virtual no tiene salida a Internet, que el nombre del Host no coincide con el del fichero config o que los permisos de ~/.ssh en el servidor son demasiado abiertos.

## 1.5 Preparar la carpeta de trabajo y las herramientas

En la terminal de VS Code (es decir, en la máquina virtual), instala las herramientas y crea la carpeta de trabajo:

```bash
sudo apt update && sudo apt install -y shellcheck dos2unix
mkdir -p ~/ut2/ejercicios
```

> **💡 Idea clave: dónde está cada cosa**
>
> La **máquina virtual es tu laboratorio**: allí escribes y ejecutas los scripts, en ~/ut2/ejercicios. Se puede romper o reinstalar sin que pierdas nada importante.
>
> Tu **repositorio de documentación está solo en tu equipo**, como hasta ahora: no se clona en la máquina virtual ni se guardan allí credenciales de GitHub.
>
> Regla: **se edita siempre en la máquina virtual; el repositorio solo recibe copias**. Al terminar cada bloque copiarás los scripts a tu repositorio, como se explica en el apartado 1.8.

Después:

- Abre la carpeta con **Archivo → Abrir carpeta…** y elige /home/tu_usuario/ut2/ejercicios.

- En el panel de extensiones, busca **ShellCheck** (de Timon Wong) y pulsa **Instalar en SSH: ubuntu-aso**.

- En **Archivo → Preferencias → Configuración**, busca eol y pon **Files: Eol** en \n. Así los ficheros nuevos se guardan con finales de línea de Linux.

## 1.6 Primer script

Crea el fichero hola.sh desde el explorador de VS Code con este contenido:

```bash
#!/bin/bash
# hola.sh - Mi primer script
echo "Hola, $USER. Hoy es $(date +%A)."
echo "Estás en el equipo $(hostname)."
```

![](./media/image1.png)

Guárdalo, dale permiso de ejecución y ejecútalo desde la terminal de VS Code:

```bash
chmod u+x hola.sh
./hola.sh
```

![](./media/image2.png)

Ahora comprueba **dónde** está y dónde se ejecuta:

- Busca hola.sh en el explorador de archivos de tu equipo (fuera de VS Code). ¿Está?

- Desde una terminal de **tu equipo**, ejecútalo en remoto sin abrir sesión: ssh ubuntu-aso "~/ut2/ejercicios/hola.sh". ¿Qué nombre de equipo muestra?

## 1.7 Formas de ejecutar un script

Un script se puede ejecutar de dos formas. Prueba las dos:

```bash
./hola.sh
bash hola.sh
```

![](./media/image3.png)

Ahora quita el permiso de ejecución y vuelve a probar las dos formas:

```bash
chmod u-x hola.sh
./hola.sh
bash hola.sh
```

¿Qué cambia? ¿Por qué una de las dos sigue funcionando? Al terminar, vuelve a darle el permiso con chmod u+x hola.sh.

## 1.8 Copiar los scripts a tu repositorio

Al terminar cada bloque, copia tus scripts desde la máquina virtual al repositorio de tu equipo. Abre una terminal **en tu equipo**, sitúate en la carpeta de tu repositorio y crea la carpeta de la unidad (solo la primera vez):

```bash
cd ruta/de/tu/repositorio
mkdir -p ut2/ejercicios
```

Después copia los scripts con scp, que usa la misma conexión SSH y el mismo alias ubuntu-aso:

```bash
scp ubuntu-aso:~/ut2/ejercicios/*.sh ut2/ejercicios/
```

En Windows usa la misma orden en PowerShell (mkdir ut2\ejercicios la primera vez). Comprueba que los ficheros han llegado y haz el commit y el push como haces habitualmente. Hazlo ahora con hola.sh.

> **⚠ Atención**
>
> No modifiques las copias del repositorio: si cambias un script, hazlo en la máquina virtual y vuelve a copiarlo. Si editas las dos copias, acabarán siendo distintas y no sabrás cuál es la buena.

# 2. Variables, comillas y parámetros

## 2.1 Asignar y usar variables

Crea variables.sh con tres variables, servidor, puerto y entorno, y muéstralas. Muestra también el nombre de un fichero de log formado por el nombre del servidor seguido de \_acceso.log y el de una copia con la fecha, por ejemplo web01-2026-10-20.tar.gz.

Antes de terminarlo, provoca dos errores a propósito y anota el mensaje de cada uno:

- Escribe la asignación con espacios: servidor = "web01".

- Escribe el nombre del log sin llaves: \$servidor_acceso.log. ¿Qué sale y por qué?

## 2.2 Comillas: predice y comprueba

En la terminal, define nombre=Ana. **Antes** de ejecutar cada orden, escribe en la tabla lo que crees que mostrará. Después ejecútala y anota el resultado real:

| **Orden**                  | **Lo que creo** | **Lo que sale** |
|----------------------------|-----------------|-----------------|
| echo "Hola \$nombre"       |                 |                 |
| echo 'Hola \$nombre'       |                 |                 |
| echo "Hola \\nombre"       |                 |                 |
| echo "Hoy es \$(date +%A)" |                 |                 |
| echo 'Hoy es \$(date +%A)' |                 |                 |
| echo "Ruta: ~"             |                 |                 |
| echo Ruta: ~               |                 |                 |

## 2.3 Comillas y espacios

```bash
mkdir -p ~/pruebas_comillas && cd ~/pruebas_comillas
fichero="informe final.txt"
touch $fichero
ls
touch "$fichero"
ls -l
```

¿Cuántos ficheros se han creado y cómo se llaman? Explica qué ha pasado con la primera orden touch. Borra la carpeta al terminar.

## 2.4 Sustitución de comandos

Crea resumen.sh, que guarde en variables con \$(...) y muestre en dos o tres frases: tu usuario, el nombre del equipo, la fecha con el formato 20/10/2026 a las 09:15, el número de procesos en ejecución y la versión del kernel. Pistas: whoami, hostname, date, ps -e --no-headers \| wc -l, uname -r.

## 2.5 Parámetros de posición

Crea saluda.sh, que reciba un nombre y, opcionalmente, un departamento (si no se indica, Sistemas). Debe mostrar el nombre del script, el número de argumentos, todos los argumentos y un saludo. Pruébalo así y explica la diferencia entre las dos primeras ejecuciones:

```bash
./saluda.sh Ana Recursos Humanos
./saluda.sh Ana "Recursos Humanos"
./saluda.sh Luis
```

# 3. Entrada, salida y redirecciones

## 3.1 Tablas con printf

Crea tabla_usuarios.sh, que muestre una tabla alineada con el usuario, el UID y la shell de tres cuentas: la tuya, root y nobody. Usa printf con anchos fijos y obtén los datos con id -u usuario y getent passwd usuario \| cut -d: -f7.

```bash
USUARIO UID SHELL
------------ -------- -----------------
ana 1000 /bin/bash
root 0 /bin/bash
nobody 65534 /usr/sbin/nologin
```

## 3.2 Pedir datos con read

Crea alta_simulada.sh, que pida un nombre de usuario, un departamento y una contraseña (sin mostrarla en pantalla) y después muestre un resumen. **No muestres la contraseña**: muestra solo cuántos caracteres tiene, con \${#clave}.

## 3.3 Redirecciones

Ejecuta estas órdenes en la terminal y, después de cada grupo, mira el contenido de los ficheros con cat:

```bash
ls /etc/hostname /no_existe
ls /etc/hostname /no_existe > salida.txt
ls /etc/hostname /no_existe > salida.txt 2> errores.txt
ls /etc/hostname /no_existe &> todo.txt
ls /etc/hostname /no_existe 2> /dev/null
date >> salida.txt; date >> salida.txt
```

Responde: ¿por qué en la segunda orden sigue saliendo un mensaje en pantalla? ¿Cuántas líneas tiene salida.txt al final y por qué?

## 3.4 Un registro de actividad

Crea registra.sh, que **añada** al fichero ~/ut2/ejercicios/registro.log una línea con la fecha y hora, tu usuario y el mensaje que reciba como argumentos. Ejecútalo varias veces con mensajes distintos y comprueba el fichero con tail registro.log:

```bash
./registra.sh Copia de seguridad terminada
./registra.sh "Reinicio del servicio ssh"
```

```bash
2026-10-20 09:20:13 [ana] Copia de seguridad terminada
2026-10-20 09:21:40 [ana] Reinicio del servicio ssh
```

# 4. Operaciones aritméticas y códigos de salida

## 4.1 Calculadora

Crea calcula.sh, que reciba dos números enteros y muestre su suma, resta, producto, división entera, resto y qué porcentaje es el primero del segundo (con dos decimales, usando bc). Pruébalo con 17 5 y con 17 0. ¿Qué pasa en el segundo caso? Lo resolverás en el bloque 5.

## 4.2 El error del contador

En la terminal, ejecuta y explica el resultado de cada grupo de órdenes:

```bash
total=0; total=$total+1; total=$total+1; echo "$total"
total=0; total=$((total + 1)); total=$((total + 1)); echo "$total"
```

## 4.3 Códigos de salida

Ejecuta cada orden y, justo después, echo \$?. Completa la tabla:

| **Orden**                                           | **Código** | **¿Qué indica?** |
|-----------------------------------------------------|------------|------------------|
| ls /etc/hostname                                    |            |                  |
| ls /no_existe                                       |            |                  |
| grep -q root /etc/passwd                            |            |                  |
| grep -q pepe /etc/passwd                            |            |                  |
| comando_inventado                                   |            |                  |
| /etc/hostname (un fichero sin permiso de ejecución) |            |                  |

## 4.4 El código de salida de tus scripts

Crea salida.sh, que muestre un mensaje y termine con el código que reciba como argumento (exit "\$1"). Prueba ./salida.sh 0; echo \$? y ./salida.sh 3; echo \$?. ¿Qué indica cada código? ¿Para qué sirve que tus scripts terminen con un código de salida?

## 4.5 Encadenar con && y \|\|

```bash
mkdir ~/prueba_cadena && echo "Creada" || echo "No se ha podido crear"
```

Ejecuta la orden dos veces seguidas. Explica por qué el resultado cambia. Borra la carpeta al terminar.

# 5. Condiciones

## 5.1 ¿Qué es esta ruta?

Crea tipo_ruta.sh, que reciba una ruta y:

1.  Si no recibe exactamente un argumento, muestre cómo se usa en la salida de errores y termine con código 1.

<!-- -->

4.  Si la ruta no existe, lo diga y termine con código 2.

5.  Si es un fichero, muestre su tamaño en bytes (stat -c %s); si es un directorio, cuántos elementos contiene; si es otra cosa, que existe pero no es ni lo uno ni lo otro.

6.  Indique si puedes leerla, modificarla y ejecutarla.

Pruébalo con /etc/hosts, /etc, /dev/null, /etc/shadow, una ruta que no exista y sin argumentos.

## 5.2 ¿Existe y es administrador?

Crea comprueba_usuario.sh, que reciba un nombre de usuario y diga si existe (usa el código de salida de id usuario &\> /dev/null como condición del if) y, si existe, si pertenece al grupo sudo (pista: id -nG usuario \| grep -qw sudo). Si no existe, código de salida 2. Pruébalo con tu usuario, con root y con uno que no exista.

## 5.3 Menú con case

Crea menu_red.sh, que muestre un menú, lea una opción con read y la ejecute con case:

```bash
1) Direcciones IP -> ip -br address
2) Puerta de enlace -> ip route | grep default
3) Servidores DNS -> resolvectl status | grep "DNS Servers"
4) Probar conexión a Internet -> ping -c 2 8.8.8.8 (muestra solo "Hay conexión" o "Sin conexión")
```

Si la opción no es válida, debe mostrar un error y terminar con código 1.

## 5.4 La trampa de \> en las condiciones

```bash
cd ~/ut2/ejercicios
[ 10 > 9 ] && echo "verdadero"
ls
[ 10 -gt 9 ] && echo "verdadero"
[ 2 -gt 10 ] || echo "falso"
```

¿Qué fichero ha aparecido y por qué? Bórralo. Vuelve a calcula.sh y haz que, si el segundo número es 0, muestre un error y termine con código 1 sin calcular nada.

# 6. Bucles

## 6.1 Recorrer una lista

Crea servicios.sh, que recorra con for la lista ssh cron rsyslog apache2, muestre el estado de cada servicio (systemctl is-active) y cuente cuántos están activos.

```bash
ssh active
cron active
rsyslog active
apache2 inactive
Servicios activos: 3 de 4
```

## 6.2 Recorrer un rango

Crea crea_carpetas.sh, que reciba un número N (por defecto, 5) y cree en ~/ut2/pruebas las carpetas alumno01, alumno02… hasta N. Pista: printf "alumno%02d" "\$i". Prueba con 3 y con 12, y borra la carpeta pruebas al terminar.

## 6.3 Recorrer ficheros

Crea logs.sh, que recorra los ficheros /var/log/\*.log y muestre el nombre y el tamaño de cada uno (du -h), y al final cuántos hay.

## 6.4 Leer un fichero línea a línea

Crea shells.sh, que lea /etc/passwd con while IFS=: read -r … y cuente cuántas cuentas usan Bash, cuántas no pueden iniciar sesión (nologin o false) y cuántas otra shell. Usa un case dentro del bucle. Comprueba un resultado con grep -c "/bin/bash\$" /etc/passwd.

Después, cambia la última línea del bucle done \< /etc/passwd por una tubería (cat /etc/passwd \| while …). ¿Qué ocurre con los contadores? Explícalo y deja la versión correcta.

## 6.5 Repetir hasta que funcione

Crea espera_red.sh, que reciba un equipo (por defecto 8.8.8.8) y, con until, haga ping cada segundo hasta que responda, con un máximo de 5 intentos. Si se agotan, debe terminar con código 1. Pruébalo con tu puerta de enlace y con una IP de tu red que no exista.

# 7. Depuración

Descarga de Teams contar.sh y media.sh y cópialos a tu carpeta de trabajo (puedes arrastrarlos al explorador de VS Code). Corrige los errores **de uno en uno** y anota en una tabla, para cada error, la línea, el tipo (sintaxis, ejecución o lógica), el mensaje o síntoma, la herramienta con la que lo encontraste y la corrección.

## 7.1 Errores de sintaxis

```bash
1 #!/bin/bash
2 # contar.sh - Cuenta los ficheros y directorios de una ruta
3 ruta=${1:-.}
4 ficheros=0
5 directorios=0
6
7 for e in "$ruta"/*; do
8 if [ -f "$e" ]; then
9 ficheros=$((ficheros + 1))
10 elif [ -d "$e" ] then
11 directorios=$((directorios + 1))
12 fi
13 done
14
15 echo "En $ruta hay $ficheros ficheros y $directorios directorios
```

```bash
bash -n contar.sh
```

Corrige el error que indica, vuelve a ejecutar bash -n y repite hasta que no muestre nada. ¿Coincide la línea del mensaje con la del error? Mira también qué marca la extensión ShellCheck en VS Code. Cuando funcione, pruébalo con ./contar.sh /etc.

## 7.2 Errores de ejecución y de lógica

```bash
1 #!/bin/bash
2 # media.sh - Calcula la suma y la media de los números recibidos
3 suma=0
4 for n in $@; do
5 suma=$suma+$n
6 done
7 media=$((suma / $#))
8 echo "Números: $#"
9 echo "Suma: $sum"
10 echo "Media: $media"
```

```bash
./media.sh 4 6 8
./media.sh
export PS4='+ línea ${LINENO}: '
bash -x media.sh 4 6 8
bash -u media.sh 4 6 8
shellcheck media.sh
```

Corrige todos los errores. Pista: hay uno que solo aparece cuando corriges otro. El script corregido debe dar Suma: 18 y Media: 6 con 4 6 8, mostrar un mensaje de uso y terminar con código 1 si no recibe números, y pasar ShellCheck sin avisos.

## 7.3 Finales de línea de Windows

Reproduce el error más habitual al trabajar desde Windows. En VS Code, abre hola.sh, haz clic en **LF** en la barra inferior, cámbialo a **CRLF** y guarda. Después:

```bash
./hola.sh
bash hola.sh
file hola.sh
cat -A hola.sh | head -n 3
```

Anota los mensajes. ¿Parece que bash hola.sh funciona? Ejecuta bash hola.sh \| cat -A y fíjate en el final de cada línea. Corrígelo de dos formas: volviendo a **LF** en VS Code, y con dos2unix hola.sh (repite el cambio a CRLF para probar la segunda).

# 8. Documentación y repositorio

## 8.1 Comentarios útiles

Este script funciona, pero está mal documentado:

```bash
#!/bin/bash
# script
x=$(df --output=pcent / | tail -n 1 | tr -dc '0-9') # x es igual a df
if [ "$x" -ge 80 ]; then # si x es mayor o igual que 80
echo "Aviso: $x" # muestra aviso
else # si no
echo "OK: $x" # muestra ok
fi # fin del if
```

Reescríbelo como disco.sh: cabecera completa, un nombre de variable descriptivo, el umbral en una variable (por defecto 80, o el que se pase como argumento), comentarios que expliquen el **porqué** y no el **qué**, y códigos de salida 0 (correcto) y 1 (supera el umbral) documentados.

## 8.2 Cabecera y ayuda

Añade a servicios.sh (bloque 6) la cabecera completa y una opción -h o --help que explique cómo se usa. Mejóralo para que, si recibe nombres de servicios como argumentos, revise esos en lugar de la lista fija. Pista: set -- ssh cron rsyslog apache2 cuando no haya argumentos y for servicio in "\$@".

## 8.3 README y entrega en el repositorio

Copia por última vez todos tus scripts al repositorio de tu equipo (apartado 1.8). Después, **en tu equipo**, crea ut2/ejercicios/README.md según el apartado 10 de este documento y haz el commit y el push.

Comprueba en la web de GitHub que están todos los scripts y que el README se ve correctamente.

# 9. Lista de autoevaluación

Marca lo que has conseguido. Esta lista no tiene nota: sirve para que sepas qué te falta repasar antes de la práctica evaluable.

|     | **Compruébalo**                                                                                                                |
|-----|--------------------------------------------------------------------------------------------------------------------------------|
| ☐   | Me conecto a la máquina virtual desde VS Code con Remote - SSH usando un Host del fichero config.                              |
| ☐   | Sé explicar en qué máquina se guarda y se ejecuta un script cuando trabajo con VS Code en remoto.                              |
| ☐   | Sé ejecutar un script con ./ y con bash, y qué necesita cada forma.                                                            |
| ☐   | Asigno variables sin espacios, uso \${} cuando hace falta y pongo las variables entre comillas.                                |
| ☐   | Uso \$(...) para guardar la salida de un comando y \$1, \$#, \$\*, \${1:-valor} para los parámetros.                           |
| ☐   | Uso printf para alinear columnas y read -r (con -s para contraseñas) para pedir datos.                                         |
| ☐   | Distingo \>, \>\>, 2\>, &\> y /dev/null, y envío los errores de mis scripts a la salida de errores.                            |
| ☐   | Opero con \$(( )), sé por qué total=\$total+1 no suma y uso bc para los decimales.                                             |
| ☐   | Consulto \$?, termino mis scripts con exit y uso && y \|\|.                                                                    |
| ☐   | Escribo condiciones con \[ \] y operadores de números, cadenas y ficheros, y uso case.                                         |
| ☐   | Recorro listas, rangos, ficheros y líneas de un fichero con for y while read, y sé por qué no usar una tubería con contadores. |
| ☐   | Encuentro errores con bash -n, bash -x, bash -u y ShellCheck, y sé corregir los finales de línea CRLF.                         |
| ☐   | Mis scripts tienen cabecera, comentarios útiles y ayuda con -h.                                                                |
| ☐   | Copio mis scripts de la máquina virtual al repositorio de mi equipo con scp y los subo a GitHub.                               |

# 10. Qué subir a tu repositorio de documentación

En la carpeta ut2/ejercicios de tu repositorio, un fichero README.md que incluya:

- **Entorno:** cómo te conectas desde VS Code (tu bloque Host del fichero config, sin datos sensibles) y una captura con **SSH: ubuntu-aso** en la barra inferior.

- **Scripts:** todos los de los bloques 1 a 8, como ficheros .sh, y para cada uno una línea que explique qué hace y un ejemplo de ejecución con su salida, como texto.

- **Respuestas:** las preguntas de los ejercicios (1.6, 1.7, 2.1, 2.3, 2.5, 3.3, 4.1, 4.2, 4.4, 4.5, 5.4 y 6.4) y las tablas de 2.2 y 4.3.

- **Depuración:** la tabla de errores del bloque 7 y los mensajes del problema CRLF.

- **Problemas y soluciones:** qué falló, cómo lo averiguaste y qué hiciste para arreglarlo.

> **💡 Nota**
>
> Todo lo que subas debe poder explicarse. La profesora puede pedirte una breve explicación oral de cualquier script de tu repositorio.
