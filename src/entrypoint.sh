#!/bin/bash

set -m

# Add elasticsearch as command if needed
if [ "${1:0:1}" = '-' ]; then
	set -- elasticsearch "$@"
fi

if [ "$NODE_NAME" = "" ]; then
	export NODE_NAME=$HOSTNAME
fi

/run/miscellaneous/restore_config.sh
cat /elasticsearch/config/elasticsearch.yml
/run/auth/certificates/gen_all.sh

chown -R elasticsearch:elasticsearch /elasticsearch

# Run as user "elasticsearch" if the command is "elasticsearch"
if [ "$1" = 'elasticsearch' -a "$(id -u)" = '0' ]; then
	set -- su-exec elasticsearch "$@"
	echo ES_JAVA_OPTS="-Des.network.host=$NETWORK_HOST -Des.logger.level=$LOG_LEVEL"  $@
	ES_JAVA_OPTS="-Des.network.host=$NETWORK_HOST -Des.logger.level=$LOG_LEVEL"  $@ &
else
	$@ &
fi

/run/miscellaneous/wait_until_started.sh
/run/miscellaneous/index_level_settings.sh

/run/auth/users.sh
/run/auth/sgadmin.sh

fg
