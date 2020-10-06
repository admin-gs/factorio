FROM ubuntu:focal

RUN apt-get update && \
        apt-get upgrade -y && \
        apt-get install -y curl xz-utils

WORKDIR /app
COPY ./entrypoint.sh ./entrypoint.sh
RUN curl -L -o factorio.tar.xz https://www.factorio.com/get-download/1.0.0/headless/linux64
RUN tar xf factorio.tar.xz
RUN mv factorio/* .
RUN rm -rf factorio factorio.tar.xz
ENV PATH="$PATH:/app/bin/x64"
RUN factorio --version

ENTRYPOINT ["/app/entrypoint.sh"]
