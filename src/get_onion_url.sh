#!/bin/bash

docker cp onion:/var/lib/tor/hidden_service/hostname .
cat hostname
