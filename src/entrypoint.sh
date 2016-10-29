#!/bin/bash

set -m

/run/miscellaneous/perf.sh

/docker-entrypoint.sh "$@" &

/run/miscellaneous/wait_until_started.sh

/run/users/elastic.sh
/run/users/kibana.sh

fg