#!/bin/bash

if [ ! -f "/config/world.zip" ]; then
  echo "This is the first run, generating map...."
  mkdir -p /config
  cp -n /app/data/server-settings.example.json /config/server-settings.json
  cp -n /app/data/map-gen-settings.example.json /config/map-gen-settings.json
  cp -n /app/data/map-settings.example.json /config/map-settings.json
  factorio --create "/config/world" \
    --map-gen-settings /config/map-gen-settings.json \
    --map-settings /config/map-settings.json \
else
  echo "A map has already been generated!"
fi

jq \
  --arg serverName "$FACTORIO_SERVER_NAME" \
  --arg serverDescription "$FACTORIO_SERVER_DESCRIPTION" \
  --arg serverPassword "$FACTORIO_SERVER_PASSWORD" \
  --arg serverUsername "$FACTORIO_SERVER_USERNAME" \
  --arg serverToken "$FACTORIO_SERVER_TOKEN" \
  '. + {
    "name": $serverName,
    "description": $serverDescription,
    "game_password": $serverPassword,
    "username": $serverUsername,
    "token": $serverToken
   }' \
   /config/server-settings.json > /config/server-settings.json.bak && \
   mv /config/server-settings.json.bak /config/server-settings.json

echo "Starting..."
factorio --start-server "/config/world" \
    --port "$FACTORIO_SERVER_PORT" \
    --server-settings /config/server-settings.json \
    --map-gen-settings /config/map-gen-settings.json \
    --map-settings /config/map-settings.json \
    --mod-directory /config/mods \
    --console-log /config/server.log \
    --server-banlist /config/server-banlist.json

