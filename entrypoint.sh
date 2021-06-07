#!/bin/sh

set -e

aws eks update-kubeconfig \
  --region eu-west-2 \
  --name nep-data-dev-main --kubeconfig kubeconfig

#echo ${KUBE_CONFIG_DATA} | base64 -d > kubeconfig
export KUBECONFIG="${PWD}/kubeconfig"

echo "running entrypoint command(s)"

response=$(sh -c " $*")

echo "::set-output name=response::$response"
