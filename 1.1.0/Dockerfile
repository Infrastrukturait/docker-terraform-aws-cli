#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "./build.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#
# templater engine: mustash 0.1.0 (https://github.com/Infrastrukturait/mustash)

FROM docker.io/hashicorp/terraform:1.1.0

LABEL maintainer="Infrastruktura.IT DevOps Team <maintainers@infrastruktura.it>"

RUN apk add --no-cache \
        python3 \
        py3-pip \
    && pip3 install --upgrade pip \
    && pip3 install \
        awscli \
    && rm -rf /var/cache/apk/*

RUN aws --version

