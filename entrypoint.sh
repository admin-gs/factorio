#!/bin/bash

if [ ! -d "/app/saves/default" ]; then
  echo "This is the first run, generating map...."
  factorio --create "/app/saves/default";
else
  echo "A map has already been generated!"
fi

echo "Starting..."
factorio --start-server "/app/saves/default"
