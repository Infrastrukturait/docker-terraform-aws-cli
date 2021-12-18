#!/bin/sh

if [[ "$CIRCLE_BRANCH" == main ]]; then
    CURR=$(pwd)
    LATEST_VER=$(cat ./latest)
    DOCKERFILES=$(git show --name-status --oneline | tail -n +2 | egrep "(.*)/Dockerfile")
    if test -z "$DOCKERFILES"
    then
        echo "Nothing to do."
        exit 0
    fi
    docker login -u $DOCKER_USER -p $DOCKER_PASSWORD dcr.apz.pl:5000
    while IFS= read -r i; do
        cd $CURR
        if [[ "$i" =~ ^A.* ]]; then
            i=$(echo $i | awk '{print $2}')
            version=$(echo $i | awk -F\/ '{print $1}')
            meta=$(echo $i | awk -F\/ '{print $2}')
            cd  "./${version}"
            if [[ "$meta" != "Dockerfile" ]]; then
                cd "./${meta}"
                tag="${version}-${meta}"
            else
                tag="${version}"
            fi
            unset meta
            docker build --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') --build-arg VCS_REF=$CIRCLE_BUILD_NUM -t ${DOCKER_NAMESPACE}/${DOCKER_NAME}:$tag .
            if [[ "${LATEST_VER}" == "$tag" ]]; then
                docker tag ${DOCKER_NAMESPACE}/${DOCKER_NAME}:$tag ${DOCKER_NAMESPACE}/${DOCKER_NAME}:latest
            fi
            cd $CURR
        fi
        if [[ "$i" =~ ^M.* ]]; then
            i=$(echo $i | awk '{print $2}')
            version=$(echo $i | awk -F\/ '{print $1}')
            meta=$(echo $i | awk -F\/ '{print $2}')
            cd  "./${version}"
            if [[ "$meta" != "Dockerfile" ]]; then
                cd "./${meta}"
                tag="${version}-${meta}"
            else
                tag="${version}"
            fi
            unset meta
            docker build --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') --build-arg VCS_REF=$CIRCLE_BUILD_NUM -t ${DOCKER_NAMESPACE}/${DOCKER_NAME}:$tag .
            if [[ "${LATEST_VER}" == "$tag" ]]; then
            if [[ "${LATEST_VER}" == "$tag" ]]; then
                docker tag ${DOCKER_NAMESPACE}/${DOCKER_NAME}:$tag ${DOCKER_NAMESPACE}/${DOCKER_NAME}:latest
            fi
            cd $CURR
        fi
        if [[ "$i" =~ ^R.* ]]; then
            i=$(echo $i | awk '{print $3}')
            version=$(echo $i | awk -F\/ '{print $1}')
            meta=$(echo $i | awk -F\/ '{print $2}')
            cd  "./${version}"
            if [[ "$meta" != "Dockerfile" ]]; then
                cd "./${meta}"
                tag="${version}-${meta}"
            else
                tag="${version}"
            fi
            unset meta
            docker build --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') --build-arg VCS_REF=$CIRCLE_BUILD_NUM -t ${DOCKER_NAMESPACE}/${DOCKER_NAME}:$tag .
            if [[ "${LATEST_VER}" == "$tag" ]]; then
                docker tag ${DOCKER_NAMESPACE}/${DOCKER_NAME}:$tag ${DOCKER_NAMESPACE}/${DOCKER_NAME}:latest
            fi
            cd $CURR
        fi
        if [[ "$i" =~ ^D.* ]]; then
            echo ""
            # TODO ヽ(⩹╭╮⩺)ﾉ
        fi
    done < <(printf '%s\n' "$DOCKERFILES")
else
    echo "Current branch is not main, skip";
fi
