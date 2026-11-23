#!/bin/bash

servidor="web01"
puerto=8080
entorno="produccion"
fecha="$(date +%Y-%m-%d)"
nombre="${date}.log"

echo "Servidor: $servidor, Puerto: $puerto, Entorno: $entorno"
echo "$servidor esta escuchando en el puerto $puerto en el entorno de $entorno" 
>> ${servidor}_acceso.log
echo "Fecha: $(fecha)" > ${nombre}