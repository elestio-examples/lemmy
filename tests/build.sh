#!/usr/bin/env bash
cp -rf docker/* ./
rm -f docker-compose.yml
mv docker-compose-new.yml docker-compose.yml
docker buildx build . --output type=docker,name=elestio4test/lemmy:latest | docker load
