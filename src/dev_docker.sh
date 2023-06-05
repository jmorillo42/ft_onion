#!/bin/bash

docker build -t onion .
docker run -ti --name onion -p 80:80 -p 4242:4242 --rm onion
