#!/bin/bash

export PORT=5101
export MIX_ENV=prod
export GIT_PATH=/home/memory/src/tasktrack 

PWD=`pwd`
if [ $PWD != $GIT_PATH ]; then
	echo "Error: Must check out git repo to $GIT_PATH"
	echo "  Current directory is $PWD"
	exit 1
fi

if [ $USER != "memory" ]; then
	echo "Error: must run as user 'memory'"
	echo "  Current user is $USER"
	exit 2
fi

mix deps.get
(cd assets && npm install)
(cd assets && ./node_modules/brunch/bin/brunch b -p)
mix phx.digest
mix release --env=prod

mkdir -p ~/www
mkdir -p ~/old

NOW=`date +%s`
if [ -d ~/www/tasktrack ]; then
	echo mv ~/www/tasktrack ~/old/$NOW
	mv ~/www/tasktrack ~/old/$NOW
fi

mkdir -p ~/www/tasktrack
REL_TAR=~/src/tasktrack/_build/prod/rel/tasktrack/releases/0.0.1/tasktrack.tar.gz
(cd ~/www/tasktrack && tar xzvf $REL_TAR)

createuser -d tasktrack-prod
prod mix ecto.drop
prod mix ecto.create
prod mix ecto.migrate

crontab - <<CRONTAB
@reboot bash /home/memory/src/tasktrack/start.sh
CRONTAB

#. start.sh
