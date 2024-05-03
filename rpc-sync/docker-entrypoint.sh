#! /bin/sh

dasel put -v "${RPC_PORT}" -f /app/config.toml 'RPC.Port'
dasel put -v "${WS_PORT}" -f /app/config.toml 'RPC.WebSockets.Port'
dasel put -v "production" -f /app/config.toml 'Log.Environment'

exec "$@"
