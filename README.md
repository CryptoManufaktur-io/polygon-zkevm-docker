# Overview

Docker Compose for Polygon zkEVM node.

The `./zkevm` script can be used as a quick-start:

`./zkevm install` brings in docker-ce, if you don't have Docker installed already.

`cp default.env .env`

`nano .env` and adjust variables as needed, particularly `ZKEVM_NETWORK` and `ZKEVM_NODE_ETHERMAN_URL`

`./zkevm up`

To update the software, run `./zkevm update` and then `./zkevm up`

If meant to be used with [central-proxy-docker](https://github.com/CryptoManufaktur-io/central-proxy-docker) for traefik
and Prometheus remote write; use `:ext-network.yml` in `COMPOSE_FILE` inside `.env` in that case.

This is Polygon zkEVM Docker v1.0.0
