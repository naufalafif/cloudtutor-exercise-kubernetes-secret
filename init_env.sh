#!/bin/bash
echo "Preparing Machine"

while ! docker info >/dev/null 2>&1; do
    echo "Waiting for Docker daemon to start..."
    sleep 1
done

kind create cluster --image=kindest/node:v1.26.3
echo "Machine Ready"