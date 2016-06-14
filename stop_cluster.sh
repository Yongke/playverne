#!/bin/bash

DOCKERNAMEPREFIX=dockervernemq-

for i in {2..8}; do
    docker kill  ${DOCKERNAMEPREFIX}${i} >/dev/null 2>&1
    docker rm  ${DOCKERNAMEPREFIX}${i}
done
