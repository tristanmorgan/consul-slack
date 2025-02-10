#!/bin/sh

export DOCKER_HOST=ssh://tristan@inspirone.node.home.consul

TS_VAR=$(date +%s)
docker build --pull --progress plain --platform=linux/amd64 -t registry.service.home.consul/consul-slack:$TS_VAR-amd64 .
docker push registry.service.home.consul/consul-slack:$TS_VAR-amd64
docker build --pull --progress plain --platform=linux/arm64/v8 -t registry.service.home.consul/consul-slack:$TS_VAR-arm64 .
docker push registry.service.home.consul/consul-slack:$TS_VAR-arm64

docker manifest create registry.service.home.consul/consul-slack:$TS_VAR --amend registry.service.home.consul/consul-slack:$TS_VAR-arm64 --amend registry.service.home.consul/consul-slack:$TS_VAR-amd64
docker manifest push registry.service.home.consul/consul-slack:$TS_VAR

docker manifest create registry.service.home.consul/consul-slack:latest --amend registry.service.home.consul/consul-slack:$TS_VAR-arm64 --amend registry.service.home.consul/consul-slack:$TS_VAR-amd64
docker manifest push registry.service.home.consul/consul-slack:latest
