#!/bin/bash

set -x
set -e

THIS_SCRIPT="$(readlink -e "$0")"
DOCKER_SYNAPSE_IMAGE_TAG="matrix-synapse"

if [ $# -ne 1 ]; then
	echo "Incorrect number of parameters."
	echo "Usage: $(basename "$0") [docker-synapse build directory]"
	echo "Exiting now."
	exit 1
fi

DOCKER_SYNAPSE_BUILD_DIR="$(readlink -e "$1")"
if [ ! -d "$DOCKER_SYNAPSE_BUILD_DIR" ]; then
	echo "Error: [docker-synapse build directory] ${DOCKER_SYNAPSE_BUILD_DIR} not found."
	echo "Exiting now."
	exit 2
fi

docker build \
	-t "$DOCKER_SYNAPSE_IMAGE_TAG" \
	"$DOCKER_SYNAPSE_BUILD_DIR"

