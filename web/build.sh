#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -z "${STOATCHAT_WEBCLIENT_IMAGE_PUBLISHNAME}" ]; then
    IMAGE="stoat-web"
    echo "Warning: STOATCHAT_WEBCLIENT_IMAGE_PUBLISHNAME not set, building as ${IMAGE}" >&2
else
    IMAGE="${STOATCHAT_WEBCLIENT_IMAGE_PUBLISHNAME}"
fi
TAG="${1:-dev}"
REF="${STOATCHAT_WEB_REF:-main}"

echo "Building ${IMAGE}:${TAG} (ref: ${REF})"

docker build \
    --platform linux/amd64 \
    --build-arg STOATCHAT_WEB_REF="${REF}" \
    --build-arg CACHE_BUST="$(date +%s)" \
    -t "${IMAGE}:${TAG}" \
    "${SCRIPT_DIR}"

echo "Web container built!"