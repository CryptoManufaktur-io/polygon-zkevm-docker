ARG NODE_DOCKER_TAG

FROM hermeznetwork/zkevm-node:${NODE_DOCKER_TAG}

ARG CONFIG_URL

ADD ${CONFIG_URL} /app/config.toml
RUN chmod +r /app/config.toml
