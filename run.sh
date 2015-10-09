#!/bin/bash
set -x
#sudo modprobe openvswitch
docker info
docker run -it --rm --privileged --name test-ryu-tester test-ryu-tester /test.sh
