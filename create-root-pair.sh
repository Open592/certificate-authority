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

if ! [ -d "./ca/certs/" ]; then
    fatal "This script requires a ./ca/certs directory to be present!"
fi

# We assume we are executing at the root of the directory structure
# and that we have a `ca/` directory at the same level.
#
# We set the following environment variable which specifies where
# openssl should be storing / finding it's required files.
#
# This environment variable is referenced within the `openssl.conf`
# file.
export OPEN592_CA_ROOT_DIR="$(pwd)/ca"

openssl req \
  -config openssl.cnf \
  -key ca/private/ca.key.pem \
  -new -x509 \
  -days 7300 \
  -sha256 \
  -extensions v3_ca \
  -out ca/certs/ca.cert.pem

chmod 444 ca/certs/ca.cert.pem

openssl x509 -noout -text -in ca/certs/ca.cert.pem
