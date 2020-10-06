#!/bin/bash

mkdir -p /config
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
     /app/data/server-settings.example.json > /config/server-settings.json

if [ ! -f "/config/world.zip" ]; then
  echo "This is the first run, generating map...."
  factorio --create "/config/world";
else
  echo "A map has already been generated!"
fi

echo "Starting..."
factorio --start-server "/config/world" --port "$FACTORIO_SERVER_PORT" --server-settings /config/server-settings.json
