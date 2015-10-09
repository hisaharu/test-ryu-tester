#!/bin/bash
set -x
docker info
docker build -t test-ryu-tester .
