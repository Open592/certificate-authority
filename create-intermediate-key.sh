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

# Directory where we will output the resulting key.
readonly DIR="./ca/intermediate/private"
# Filename of the resulting key.
readonly OUTPUT_FILE="$DIR/intermediate.key.pem"

# We output the root key to $DIR and expect this directory
# to be present.
if ! [ -d $DIR ]; then
  fatal "This script requires a $DIR directory to be present!"
fi

openssl genrsa \
    -aes256 \
    -out $OUTPUT_FILE \
    4096

chmod 400 $OUTPUT_FILE
