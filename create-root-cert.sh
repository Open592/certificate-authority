#!/usr/bin/env bash

source shared.sh

# Directory where we will output the resulting certificate.
readonly DIR="./ca/certs"

if ! [ -d $DIR ]; then
  fatal "This script requires a $DIR directory to be present!"
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
  -config conf/root-openssl.cnf \
  -key ca/private/ca.key.pem \
  -new \
  -x509 \
  -days 7300 \
  -out $DIR/ca.cert.pem

chmod 444 "$DIR/ca.cert.pem"

openssl x509 -noout -text -in "$DIR/ca.cert.pem"
