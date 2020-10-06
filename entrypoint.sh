#!/bin/bash
instanceName="default"
savesPath="/app/saves"

if [ ! -d $savesPath ]; then
  echo "This is the first run, generating map...."
  factorio --create /app/saves/$instanceName;
else
  echo "A map has already been generated!"
fi

echo "Starting..."
factorio --start-server-load-latest
