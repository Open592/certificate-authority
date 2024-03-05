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

readonly ROOT_DIR="./ca/intermediate"

if ! [ -d "$ROOT_DIR/csr" ]; then
  fatal "This script requires a $ROOT_DIR/csr directory to be present!"
fi

if ! [ -d "./ca/newcerts" ]; then
  fatal "This script requires a ./ca/newcerts directory to be present!"
fi

if ! [ -d "$ROOT_DIR/certs" ]; then
  fatal "This script requires a $ROOT_DIR/certs directory to be present!"
fi

# We assume we are executing at the root of the directory structure
# and that we have a `ca/` directory at the same level.
#
# We set the following environment variable which specifies where
# openssl should be storing / finding it's required files.
#
# This environment variable is referenced within the configuration file.
export OPEN592_CA_ROOT_DIR="$(pwd)/ca"

# Create the CSR
openssl req \
  -config conf/intermediate-openssl.cnf \
  -new \
  -sha256 \
  -key "$ROOT_DIR/private/intermediate.key.pem" \
  -out "$ROOT_DIR/csr/intermediate.csr.pem"

# Create the certificate
openssl ca \
  -config conf/root-openssl.cnf \
  -extensions v3_intermediate_ca \
  -notext \
  -md sha256 \
  -in "$ROOT_DIR/csr/intermediate.csr.pem" \
  -out "$ROOT_DIR/certs/intermediate.cert.pem"

openssl x509 \
  -noout \
  -text \
  -in "$ROOT_DIR/certs/intermediate.cert.pem"

openssl verify \
  -no_check_time \
  -CAfile "./ca/certs/ca.cert.pem" \
  "$ROOT_DIR/certs/intermediate.cert.pem"

# Create certificate chain
cat "$ROOT_DIR/certs/intermediate.cert.pem" "./ca/certs/ca.cert.pem" \
  > "$ROOT_DIR/certs/ca-chain.cert.pem"

chmod 444 "$ROOT_DIR/certs/ca-chain.cert.pem"
