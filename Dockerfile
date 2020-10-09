FROM ubuntu:focal

RUN apt-get update && \
        apt-get upgrade -y && \
        apt-get install -y curl xz-utils jq

WORKDIR /app
RUN curl -L -o factorio.tar.xz https://www.factorio.com/get-download/1.0.0/headless/linux64
RUN tar xf factorio.tar.xz
RUN mv factorio/* .
RUN rm -rf factorio factorio.tar.xz
ENV PATH="$PATH:/app/bin/x64"
RUN factorio --version
COPY ./entrypoint.sh ./entrypoint.sh

ENV FACTORIO_SERVER_PORT=34197
ENV FACTORIO_SERVER_PASSWORD=""
ENV FACTORIO_SERVER_NAME="Factorio Server"
ENV FACTORIO_SERVER_DESCRIPTION="Running from docker!"
ENV FACTORIO_SERVER_SETTINGS="{}"
ENV FACTORIO_USERNAME=""
ENV FACTORIO_TOKEN=""

ENTRYPOINT ["/app/entrypoint.sh"]
