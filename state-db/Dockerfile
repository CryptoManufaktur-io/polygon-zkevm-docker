ARG POSTGRES_DOCKER_TAG

FROM postgres:${POSTGRES_DOCKER_TAG}

ARG POSTGRES_CONF_URL
ARG PROVER_INIT_SQL_URL

ADD ${POSTGRES_CONF_URL} /etc/postgresql.conf
ADD ${PROVER_INIT_SQL_URL} /docker-entrypoint-initdb.d/init.sql

RUN chmod +r /etc/postgresql.conf /docker-entrypoint-initdb.d/init.sql
