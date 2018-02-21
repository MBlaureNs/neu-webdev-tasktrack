#!/bin/bash

export PORT=5101

cd ~/www/tasktrack
./bin/tasktrack stop || true
./bin/tasktrack start

