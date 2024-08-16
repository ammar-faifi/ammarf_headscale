FROM alpine:3.17.1

ARG HEADSCALE_VERSION=0.19.0
ARG HEADSCALE_SHA256=76e62be5f8a82763995903d413fa71c57143ea0b9c21d376be66793fdb6e993a

# Upgrade system and install dependencies
RUN --mount=type=cache,sharing=private,target=/var/cache/apk \
    apk update && \
    apk upgrade && \
    apk add --no-cache wget

# Download and install headscale
RUN --mount=type=cache,target=/var/cache/apk \
    --mount=type=tmpfs,target=/tmp \
    cd /tmp && \
    wget -q -O headscale https://github.com/juanfont/headscale/releases/download/v${HEADSCALE_VERSION}/headscale_${HEADSCALE_VERSION}_linux_amd64 && \
    echo "${HEADSCALE_SHA256} *headscale" | sha256sum -c - && \
    chmod +x headscale && \
    mv headscale /usr/local/bin/ && \
    # Verify installation
    headscale version && \
    # Cleanup
    rm -rf /tmp/*

# Copy configuration
COPY ./config.yaml /etc/headscale/config.yaml

# Set the entrypoint
ENTRYPOINT ["/usr/local/bin/headscale", "serve"]
