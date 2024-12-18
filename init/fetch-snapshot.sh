#!/usr/bin/env bash
set -euo pipefail

__get_snapshot() {
  __dont_rm=0
  mkdir -p /tmp/cdk-erigon/snapshot
  cd /tmp/cdk-erigon/snapshot
  aria2c -c -x6 -s6 --auto-file-renaming=false --conditional-get=true --allow-overwrite=true "$1"
  echo "Copy completed, extracting"
  if ! __final_url=$(curl -s -I -L -o /dev/null -w '%{url_effective}' "$1"); then
    printf "Error: Failed to retrieve final URL for %s\n" "$1" >&2
    return 1
  fi
  __filename=$(basename "$__final_url")
  __filename="${__filename%%\?*}"
  if [[ "${__filename}" =~ \.tar\.zst$ ]]; then
    pzstd -c -d "${__filename}" | tar xvf - -C /tmp/cdk-erigon
  elif [[ "${__filename}" =~ \.tar\.gz$ || "${__filename}" =~ \.tgz$ ]]; then
    tar xzvf "${__filename}" -C /tmp/cdk-erigon
  elif [[ "${__filename}" =~ \.tar$ ]]; then
    tar xvf "${__filename}" -C /tmp/cdk-erigon
  elif [[ "${__filename}" =~ \.lz4$ ]]; then
    lz4 -c -d "${__filename}" | tar xvf - -C /tmp/cdk-erigon
  else
    __dont_rm=1
    echo "The snapshot file has a format that Polygon zkEVM Docker can't handle."
    echo "Please come to CryptoManufaktur Discord to work through this."
  fi
  if [ "${__dont_rm}" -eq 0 ]; then
    rm -f "${__filename}"
  fi
  # try to find the directory
  __search_dir="chaindata"
  __base_dir="/tmp/cdk-erigon/"
  __found_path=$(find "$__base_dir" -type d -path "*/$__search_dir" -print -quit)
  if [ -n "$__found_path" ]; then
    __found_path=$(dirname "$__found_path")
    if [ "${__found_path}/" = "${__base_dir}" ]; then
       echo "Snapshot extracted into ${__base_dir}chaindata"
    else
      echo "Found a directory at ${__found_path}, moving it."
      mv "$__found_path/chaindata" "$__base_dir"
      rm -rf "$__found_path"
    fi
  fi
  if [[ ! -d /tmp/cdk-erigon/chaindata ]]; then
    echo "Chaindata isn't in the expected location."
    echo "This snapshot likely won't work until the entrypoint script has been adjusted for it."
    exit 1
  fi
}

# Prep datadir
if [ -n "${SNAPSHOT}" ] && [ ! -d "/tmp/cdk-erigon/chaindata/" ]; then
  __get_snapshot "${SNAPSHOT}"
else
  echo "No snapshot fetch necessary"
fi
