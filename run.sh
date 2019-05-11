#!/bin/sh
echo "step 1"

# Docker entrypoint (pid 1), run as root
[ "$1" = "mongod" ] || exec "$@" || exit $?

echo "step 2"

# Make sure that database is owned by user mongodb
[ "$(stat -c %U /data/db)" = mongodb ] || chown -R mongodb /data/db

echo "step 3"

MONGODB_ADMIN_USERNAME=root
MONGODB_ADMIN_PASSWORD=blablabla
MONGODB_USER=my_user
MONGODB_PASSWORD=blablabla
MONGODB_DATABASE=test

echo "step 4"

sed "s/###admin_username###/$MONGODB_ADMIN_USERNAME/g" /root/pre_install.js
sed "s/###admin_password###/$MONGODB_ADMIN_PASSWORD/g" /root/pre_install.js
sed "s/###user###/$MONGODB_USER/g" /root/pre_install.js
sed "s/###password###/$MONGODB_PASSWORD/g" /root/pre_install.js
sed "s/###database###/$MONGODB_DATABASE/g" /root/pre_install.js

cat /root/pre_install.js

echo "step 5"

# Start mongod as background process
mongod --port 45788 &
echo "step 6"

# Run pre_install script to create users
mongo /root/pre_install.js
echo "step 7"

# Stop background mongod process
kill -s SIGINT $(pgrep -f mongod)
echo "step 8"


# Drop root privilege (no way back), exec provided command as user mongodb
cmd=exec; for i; do cmd="$cmd '$i'"; done
exec su -s /bin/sh -c "$cmd" mongodb
