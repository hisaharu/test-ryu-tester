#!/bin/bash
set -x
sudo modprobe openvswitch
docker info
docker run -it --privileged test-ryu-tester /test.sh
