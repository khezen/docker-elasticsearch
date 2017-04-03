#!/bin/bash

set -m

export NODE_NAME=$HOSTNAME

/run/miscellaneous/restore_config.sh
/run/auth/certificates/gen_all.sh

# Run as user "elasticsearch" if the command is "elasticsearch"
if [ "$1" = 'elasticsearch' -a "$(id -u)" = '0' ]; then
	chown -R elasticsearch:elasticsearch /usr/share/elasticsearch
	set -- gosu elasticsearch "$@"
	ES_JAVA_OPTS="-Des.network.host=$NETWORK_HOST  -Des.logger.level=INFO -Xms$HEAP_SIZE -Xmx$HEAP_SIZE" $@ &
else
	$@ &
fi

/run/miscellaneous/wait_until_started.sh
/run/miscellaneous/index_level_settings.sh

cat /usr/share/elasticsearch/config/elasticsearch.yml

/run/auth/users.sh
/run/auth/sgadmin.sh

fg
