#!/usr/bin/env bash

# change this to whatever you want, just remember it when you need to run the container
img_name=emagineovpn

# build the local docker image
docker build -t $img_name .
