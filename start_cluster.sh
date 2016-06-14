#!/bin/bash

NET=vernemq_nw
DOCKERNAMEPREFIX=dockervernemq-
SUBNET=172.30.40.0/24
IPPREFIX=172.30.40

docker network inspect $NET >/dev/null 2>&1
if [ $? -ne 0 ]; then
    docker network create -d bridge --subnet $SUBNET $NET
fi

function killdocker {
    docker kill ${DOCKERNAMEPREFIX}$1 >/dev/null 2>&1
    docker rm ${DOCKERNAMEPREFIX}$1 >/dev/null 2>&1
}

## graphite
i=2
killdocker $i
docker run -d --name ${DOCKERNAMEPREFIX}${i} --net=${NET} --ip=${IPPREFIX}.${i} \
    -p 8080:80 \
    hopsoft/graphite-statsd

## vernemq discovery node
i=3
killdocker $i
discover_ip=${IPPREFIX}.${i}
docker run -d --name ${DOCKERNAMEPREFIX}${i} --net=${NET} --ip=${discover_ip} verne

## vernemq nodes
for i in {4..7}; do
    killdocker $i
    docker run -d --name ${DOCKERNAMEPREFIX}${i} --net=${NET} \
	--ip=${IPPREFIX}.${i} verne
    sleep 10
    docker exec -it ${DOCKERNAMEPREFIX}${i} vmq-admin cluster join discovery-node=verne@${discover_ip}
done

## haproxy for tcp load balancing
i=8
killdocker $i
docker run -d --name ${DOCKERNAMEPREFIX}${i} --net=${NET} --ip=${IPPREFIX}.${i} \
-p 1883:1883 slb
