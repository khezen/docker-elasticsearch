#!/bin/bash

sysctl -w vm.max_map_count=262144
sysctl -w vm.swappiness=1
export ES_JAVA_OPTS="-Xms$heap_size -Xmx$heap_size"