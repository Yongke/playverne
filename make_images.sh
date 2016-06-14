#!/bin/bash

docker build --force-rm -t verne -f VerneMQ.Dockerfile .
docker build --force-rm -t slb -f slb.Dockerfile .

