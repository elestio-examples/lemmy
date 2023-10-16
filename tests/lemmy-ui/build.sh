#!/usr/bin/env bash
mv docker-compose-new.yml docker-compose.yml
mv nginx-new.conf nginx.conf
docker buildx build . --output type=docker,name=elestio4test/lemmy-ui:latest | docker load
