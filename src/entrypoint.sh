#!/bin/bash

set -m

/run/miscellaneous/restore_config.sh
/run/miscellaneous/edit_config.sh
/run/auth/certificates/gen_all.sh

# Run as user "elasticsearch" if the command is "elasticsearch"
if [ "$1" = 'elasticsearch' -a "$(id -u)" = '0' ]; then
	chown -R elasticsearch:elasticsearch /usr/share/elasticsearch
	set -- gosu elasticsearch "$@"
	ES_JAVA_OPTS="-Des.network.host=0.0.0.0  -Des.logger.level=INFO -Xms$HEAP_SIZE -Xmx$HEAP_SIZE" $@ &
else
	$@ &
fi

/run/miscellaneous/wait_until_started.sh

/run/auth/users.sh
/run/auth/sgadmin.sh

fg