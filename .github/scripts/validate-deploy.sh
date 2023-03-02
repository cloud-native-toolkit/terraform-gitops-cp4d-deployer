#!/usr/bin/env bash

SCRIPT_DIR=$(cd $(dirname "$0"); pwd -P)

GIT_REPO=$(cat git_repo)
GIT_TOKEN=$(cat git_token)

BIN_DIR=$(cat .bin_dir)

export PATH="${BIN_DIR}:${PATH}"

source "${SCRIPT_DIR}/validation-functions.sh"

if ! command -v oc 1> /dev/null 2> /dev/null; then
  echo "oc cli not found" >&2
  exit 1
fi

if ! command -v kubectl 1> /dev/null 2> /dev/null; then
  echo "kubectl cli not found" >&2
  exit 1
fi

if ! command -v ibmcloud 1> /dev/null 2> /dev/null; then
  echo "ibmcloud cli not found" >&2
  exit 1
fi

export KUBECONFIG=$(cat .kubeconfig)
NAMESPACE=$(cat .namespace)
COMPONENT_NAME=$(jq -r '.name // "my-module"' gitops-output.json)
BRANCH=$(jq -r '.branch // "main"' gitops-output.json)
SERVER_NAME=$(jq -r '.server_name // "default"' gitops-output.json)
LAYER=$(jq -r '.layer_dir // "2-services"' gitops-output.json)
TYPE=$(jq -r '.type // "base"' gitops-output.json)

mkdir -p .testrepo

git clone https://${GIT_TOKEN}@${GIT_REPO} .testrepo

cd .testrepo || exit 1

find . -name "*"

set -e

validate_gitops_content "${NAMESPACE}" "${LAYER}" "${SERVER_NAME}" "${TYPE}" "${COMPONENT_NAME}" "values.yaml"

check_k8s_namespace "${NAMESPACE}"


count=0
JOB=""
until [[ ! -z "$JOB" ]] || [[ $count -eq 20 ]]; do
  JOB=$(oc get job -n gitops-cp4d-deployer | grep cloud-pak-deployer | head -n1 | sed -e 's/\s.*$//')
  echo "Waiting for job: cloud-pak-deployer"

  count=$((count + 1))
  sleep 15
done

if [[ $count -eq 20 ]]; then
  echo "Timed out waiting for job: cloud-pak-deployer" >&2
  exit 1
else
  echo "Found job: ${JOB}"
fi

check_k8s_resource "${NAMESPACE}" "job" "${JOB}"

cd ..
rm -rf .testrepo
