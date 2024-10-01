#!/bin/bash

BASEDIR=$(dirname 0)/charts
mkdir -p $BASEDIR
cd $BASEDIR

echo `pwd`
git clone git@github.com:alibaba/open-local.git
chmod 775 open-local/hack/community-image-sync.sh
./open-local/hack/community-image-sync.sh

k8sImages=$(docker image ls --filter=reference='registry.k8s.io/sig-storage/*' --format '{{.Repository}}:{{.Tag}}')
