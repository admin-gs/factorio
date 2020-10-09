# Factorio Server

This image strives to be a one-click deployment for a factorio server.
It is entirely configured through environment variables.

## Usage:

**docker:**
```bash
docker run --detach \
        --name factorio-server \
        --publish 34197:34197/udp \
        --volume path/to/folder:/config \
        --env FACTORIO_SERVER_NAME="My Server" \
        --env FACTORIO_SERVER_USERNAME="ChappIO" \
        --env FACTORIO_SERVER_TOKEN="generated-token-here" \
        admings/factorio:1.0.0
```

**docker compose:**
```yml
version: '3.7'

volumes:
  world:

services:
  desert:
    image: admings/factorio:1.0.0
    environment:
      FACTORIO_SERVER_NAME: "My Factorio Server"
      FACTORIO_SERVER_DESCRIPTION: "We're in the desert. There's biters."
      FACTORIO_SERVER_PASSWORD: ssshhhh
      FACTORIO_SERVER_USERNAME: ChappIO
      FACTORIO_SERVER_TOKEN: generated-token-here
    volumes:
      - world:/config
    ports:
      - 34197:34197/udp
    # These settings allow you to attach to the container later
    # and run commands.
    tty: true
    stdin_open: true
```

## Volumes:

**`/config`**: 
    This volume contains the save games and server logs.
    Bind or mount it to preserve your world.

## Options:

**FACTORIO_SERVER_PORT**:
    (default: `34197`)
    The (UDP) listen port for this server.
    You need to publish this port on your docker container and specify it when connecting to your server from Factorio.
    If you wish to allow connections from outside your network, you need to enable port forwarding on your router.

**FACTORIO_SERVER_NAME**: 
    (default: `Factorio Server`)
    Set the server name as it appears on the public server listing.
    
**FACTORIO_SERVER_DESCRIPTION**:
    (default: `Running from docker!`)
    Set the server description as it appears on the public server listing.
    
**FACTORIO_SERVER_PASSWORD**:
    (default: none)
    If you set this value, clients will be prompted for a server password oppon connection.

**FACTORIO_USERNAME**:
    (default: none)
    Set this value to your factorio username to connect to the factorio server listing and user verification.

**FACTORIO_TOKEN**:
    (default: none)
    Set this value to your factorio [user account token](https://factorio.com/profile).

**FACTORIO_SERVER_SETTINGS**:
    (default: `{}`)
    Set this value to additional server settings in json format.
    They will override any settings specified.

## FAQ:

**Where can I request more features?**

I maintain this image over on [GitHub](https://github.com/admin-gs/factorio).
You can create [Issues](https://github.com/admin-gs/factorio/issues) or [Pull Requests](https://github.com/admin-gs/factorio/pulls) there.
Any merged pull request will automatically be deployed to [Docker hub](https://hub.docker.com/repository/docker/admings/factorio).
