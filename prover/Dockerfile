ARG PROVER_DOCKER_TAG

FROM hermeznetwork/zkevm-prover:${PROVER_DOCKER_TAG}

ARG PROVER_JSON_URL

ADD ${PROVER_JSON_URL} /usr/src/app/config.json
RUN chmod +r /usr/src/app/config.json
