#!/bin/bash

sysctl -w vm.max_map_count=262144
sysctl -w vm.swappiness=1
export ES_JAVA_OPTS=$ES_JAVA_OPTS" -Xms$HEAP_SIZE -Xmx$HEAP_SIZE"