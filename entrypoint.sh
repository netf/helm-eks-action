#!/bin/sh

set -e

aws eks update-kubeconfig \
  --region ${AWS_REGION} \
  --name ${CLUSTER_NAME} --kubeconfig kubeconfig

export KUBECONFIG="${PWD}/kubeconfig"

echo "running entrypoint command(s)"

response=$(sh -c " $*")

echo "::set-output name=response::$response"
