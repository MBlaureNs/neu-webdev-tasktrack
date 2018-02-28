#!/bin/bash

export PORT=5102

cd ~/www/tasks2
./bin/tasktrack stop || true
./bin/tasktrack start

