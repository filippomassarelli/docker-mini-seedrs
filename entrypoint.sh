
set -e

if [ -f tmp/pids/server.pid ]; then
    rm tmp/pids/server.pid
fi

exec "$@"


# This helps fix a Rails-specific issue that prevents the server from restarting when 
# a certain server.pid file pre-exists, this needs to be run on every docker start.