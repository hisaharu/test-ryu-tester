#!/bin/bash
set -e
set -x

TEST_PATH=${TEST_PATH:-of13/match/00_IN_PORT.json}

apt-get install -y openvswitch-switch
service openvswitch-switch start

for i in 21 22 23; do
	ip link add name target-$i type veth peer name tester-$i
	ip link set up dev target-$i
	ip link set up dev tester-$i
done
for SW in target tester; do
	ovs-vsctl add-br br-$SW
	for i in 21 22 23; do
		ovs-vsctl add-port br-$SW $SW-$i
	done
	ovs-vsctl set-controller br-$SW tcp:127.0.0.1:6633
	ovs-vsctl set bridge br-$SW protocols=OpenFlow13
	ovs-vsctl set-fail-mode br-$SW secure
done
sudo ovs-vsctl set bridge br-target other-config:datapath-id=0000000000000001
sudo ovs-vsctl set bridge br-tester other-config:datapath-id=0000000000000002

cd /
git clone https://github.com/osrg/ryu.git
cd ryu
pip install -r tools/pip-requires
pip install -r tools/test-requires
pip install -e .

cd /ryu/ryu/tests/switch
ryu run --test-switch-dir $TEST_PATH tester.py 2>&1 | tee /tester.log
tail -n1 /tester.log | grep '^OK'

