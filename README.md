# Overview

Docker Compose for Polygon zkEVM node. Also supports XLayer with `cdk-erigon.yml`

The `./zkevmd` script can be used as a quick-start:

`./zkevmd install` brings in docker-ce, if you don't have Docker installed already.

`cp default.env .env`

`nano .env` and adjust variables as needed, particularly `NETWORK` and `L1_RPC`

`./zkevmd up`

To update the software, run `./zkevmd update` and then `./zkevmd up`

You can share the RPC/WS ports locally by adding `:rpc-shared.yml` to `COMPOSE_FILE` inside `.env`.

If meant to be used with [central-proxy-docker](https://github.com/CryptoManufaktur-io/central-proxy-docker) for traefik
and Prometheus remote write; use `:ext-network.yml` in `COMPOSE_FILE` inside `.env` in that case.

This is Polygon zkEVM Docker v1.4.0
