#!/bin/bash

set -x
set -e

THIS_SCRIPT="$(readlink -e "$0")"
DOCKER_SYNAPSE_USERNAME="synapse"
DOCKER_BITCOIN_CONFIG_DIR_MOUNTPOINT="/home/${DOCKER_SYNAPSE_USERNAME}/config"
DOCKER_SYNAPSE_IMAGE_TAG="matrix-synapse"

if [ $# -lt 1 ]; then
	echo "Incorrect number of parameters."
	echo "Usage: $(basename "$0") [docker-synapse config dir] <docker run parameters...>"
	echo "Exiting now."
	exit 1
fi

DOCKER_SYNAPSE_CONFIG_DIR="$(readlink -e "$1")"
if [ ! -d "$DOCKER_SYNAPSE_CONFIG_DIR" ]; then
	echo "Error: [docker-synapse  config dir] ${DOCKER_SYNAPSE_CONFIG_DIR} not found."
	echo "Exiting now."
	exit 2
fi

docker run -d \
	-v "${DOCKER_SYNAPSE_CONFIG_DIR}:${DOCKER_BITCOIN_CONFIG_DIR_MOUNTPOINT}" \
	${@:2} \
	"$DOCKER_SYNAPSE_IMAGE_TAG"

