#!/bin/sh
set -e

rm -f /app/tmp/pids/server.pid

# bundle exec rails db:prepare

# exec "$@"
exec bundle exec rails s -b 0.0.0.0 -p 3000
