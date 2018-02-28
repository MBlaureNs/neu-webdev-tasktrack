#!/bin/bash

export PORT=5102
export MIX_ENV=prod
export GIT_PATH=/home/memory/src/tasks2 

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
if [ -d ~/www/tasks2 ]; then
	echo mv ~/www/tasks2 ~/old/$NOW
	mv ~/www/tasks2 ~/old/$NOW
fi

mkdir -p ~/www/tasks2
REL_TAR=~/src/tasks2/_build/prod/rel/tasktrack/releases/0.0.1/tasktrack.tar.gz
(cd ~/www/tasks2 && tar xzvf $REL_TAR)

MIX_ENV=prod mix ecto.create
MIX_ENV=prod mix ecto.migrate


crontab - <<CRONTAB
@reboot bash /home/memory/src/tasks2/start.sh
CRONTAB

#. start.sh
