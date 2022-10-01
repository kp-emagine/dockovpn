#!/usr/bin/env bash

# change this to whatever you changed the image name to in build.sh
img_name=emagineovpn

# change this to whatever your running containers name is
cont_name=emagineovpn

# kill the running container!
docker kill $cont_name;

# now delete it
docker rm $cont_name --force;

# now we can delete the image
docker rmi $img_name --force;

# now rebuild it
docker build -t $img_name .
