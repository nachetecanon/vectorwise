#!/bin/bash

. /etc/profile.d/vector.sh

# start this as root to initialise the db
/etc/init.d/actian-vectorVW start

# now complete setu as the actian user
runuser actian -c /entrypoint.sh
