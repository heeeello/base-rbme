# Introducción

Este repositorio alberga un *contenedor Docker* para montar una aplicación que haga backup usando el programa RBME, está automatizado en el Registry Hub de Docker [luispa/base-rbme](https://registry.hub.docker.com/u/luispa/base-rbme/) conectado con el el proyecto en [GitHub base-rmbe](https://github.com/LuisPalacios/base-rbme)


## Ficheros

* **Dockerfile**: Para crear el servicio
* **docker-entrypoint.sh**: Se utiliza para arrancar correctamente el contenedor creado con esta imagen

## Clonar el repositorio

Este es el comando a ejecutar para clonar el repositorio desde GitHub y poder trabajar con él directamente

    ~ $ clone https://github.com/LuisPalacios/docker-rbme.git

Luego puedes crear la imagen localmente con el siguiente comando

    $ docker build -t luispa/base-rbme ./


## Uso de la imagen

Para usar la imagen desde el registry de docker hub

    ~ $ docker pull luispa/base-rbme

o bien mediante fig, fichero fig.yml

    #
    #
    backup:

    image: luispa/base-rbme

    volumes:
    - /mnt/Backup:/backup
    - /Apps/data/backup/rbme_daily.sh:/etc/cron.daily/rbme_daily.sh

    command: /entrypoint.sh

Otra opción es ejecutarlo manualmente

    docker run -t -i -v /mnt/Backup:/backup -v /Apps/data/backup/rbme_daily.sh:/etc/cron.daily/rbme_daily.sh -h totobo luispa/base-rbme /bin/bash
    
