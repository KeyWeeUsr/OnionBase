#!/bin/sh
set -e

VERSION="1.0"
IMAGE_NAME="keyweeusr/onionbase"

docker build --tag ${IMAGE_NAME}:${VERSION} --file Dockerfile "$(pwd)"

if [ "$1" = "--push" ]
then
    docker tag ${IMAGE_NAME}:${VERSION} ${IMAGE_NAME}:latest
    docker push ${IMAGE_NAME}:${VERSION}
    docker push ${IMAGE_NAME}:latest
fi
