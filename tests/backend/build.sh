#!/usr/bin/env bash
rm -f docker/README.md
cp -rf docker/* ./
rm -f docker-compose.yml
rm -f nginx.conf
mv docker-compose-new.yml docker-compose.yml
mv nginx-new.conf nginx.conf
docker buildx build . --output type=docker,name=elestio4test/lemmy:latest | docker load
