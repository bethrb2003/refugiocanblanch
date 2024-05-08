#!/bin/bash

# Nombres fijos
CONTAINER_NAME=refugiocanblanch # Nombre del contenedor
IMAGE_NAME=refugiocanblanch # Nombre de la imagen
PORT=1002:8080  # Puerto de la aplicación
SCRIPT_DIR=$(dirname "$0")  # Obtiene el directorio del script

# Verifica si el contenedor está corriendo y detenerlo si es necesario
if [ $(docker ps -q -f name=$CONTAINER_NAME) ]; then
    echo "Deteniendo y eliminando el contenedor actual..."
    docker stop $CONTAINER_NAME
    docker rm $CONTAINER_NAME
else
    echo "No existe el contenedor $CONTAINER_NAME, se creará uno nuevo."
fi

# Verificar si la imagen existe y eliminarla si es necesario
if [ $(docker images -q $IMAGE_NAME) ]; then
    echo "Eliminando la imagen Docker..."
    docker rmi $IMAGE_NAME
else
    echo "No existe la imagen $IMAGE_NAME, se creará una nueva."
fi

# Actualizar el código fuente
echo "Actualizando el código fuente desde Git..."
cd $SCRIPT_DIR
git pull

# Reconstruir la imagen Docker
echo "Construyendo la nueva imagen Docker..."
docker build -t $IMAGE_NAME .

# Iniciar el nuevo contenedor
echo "Iniciando el nuevo contenedor..."
docker run -d --name $CONTAINER_NAME --restart=always -p $PORT $IMAGE_NAME

# Limpiar imágenes "dangling"
echo "Limpiando imágenes sin usar..."
docker image prune -f

echo "Actualización completada y contenedor reiniciado."


