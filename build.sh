#!/bin/bash

__latest=false


if test -z $1; then
    echo "Terraform version is required!"
    exit 99
else
    __terraform_version=$1
fi

if $2; then
    __latest=true
fi

mkdir -p $__terraform_version

__script_name=$0
__templater_version=$(bash ./mustash/musta.sh --version)

SCRIPT_NAME=${__script_name} \
TEMPLATER_VERSION=${__templater_version} \
TERRAFORM_VERSION=${__terraform_version} \
bash ./mustash/musta.sh -f ./Dockerfile.template -o $__terraform_version/Dockerfile

if $__latest ; then
    echo $__terraform_version > ./latest
fi
