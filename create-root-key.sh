#!/usr/bin/env bash

set -euo pipefail

log() {
    echo "[${0##*/}]: $1" >&2;
}

fatal() {
    log "<FATAL> $1";
    exit 1;
}

if ! [ -x "$(command -v openssl)" ]; then
    fatal "This script requires openssl to be installed!"
fi

# We output the root key to "./ca/private" and expect this directory
# to be present.
if ! [ -d "./ca/private" ]; then
    fatal "This script requires a ./ca/private directory to be present!"
fi

openssl genrsa \
    -aes256 \
    -out ca/private/ca.key.pem \
    4096

chmod 400 ca/private/ca.key.pem
