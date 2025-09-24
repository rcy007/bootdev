FROM ubuntu:22.04

ENV NODE_VERSION_CURRENT=21.7.0 \
    NODE_VERSION_LTS=22.20.0 \
    GO_VERSION=1.22.5 \
    GOROOT=/usr/local/go \
    GOPATH=/workspace/go \
    NVM_DIR=/root/.nvm

ENV PATH="$GOROOT/bin:$GOPATH/bin:$PATH" \
    GOPROXY=direct \
    GOSUMDB=off

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        bash \
        build-essential \
        ca-certificates \
        curl \
        git \
        openssl \
        tar \
        wget \
        xz-utils \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL "https://go.dev/dl/go${GO_VERSION}.linux-arm64.tar.gz" -o /tmp/go.tar.gz \
    && rm -rf "$GOROOT" \
    && tar -C /usr/local -xzf /tmp/go.tar.gz \
    && rm /tmp/go.tar.gz

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

RUN bash -lc "source $NVM_DIR/nvm.sh && nvm install $NODE_VERSION_CURRENT && nvm install $NODE_VERSION_LTS && nvm alias default $NODE_VERSION_LTS"

RUN mkdir -p "$GOPATH" && go install github.com/bootdotdev/bootdev@latest && cp "$GOPATH/bin/bootdev" /usr/local/bin/bootdev

ENTRYPOINT ["bash", "-c", "source $NVM_DIR/nvm.sh && exec \"$@\"", "--"]

WORKDIR /workspace

CMD ["/bin/bash"]
