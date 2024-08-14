ARG NODE_DOCKER_TAG

# Get dasel
FROM ghcr.io/tomwright/dasel:2-alpine as dasel

FROM hermeznetwork/zkevm-node:${NODE_DOCKER_TAG}

COPY --from=dasel /usr/local/bin/dasel /usr/local/bin/

ARG CONFIG_URL

ADD ${CONFIG_URL} /app/config.toml
RUN chmod +r /app/config.toml

COPY docker-entrypoint.sh /usr/local/bin/
# Belt and suspenders
RUN chmod 755 /usr/local/bin/*
