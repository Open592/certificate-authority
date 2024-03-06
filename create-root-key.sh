#!/usr/bin/env bash

source shared.sh

# Directory where we will output the resulting key.
readonly DIR="./ca/private"
# Filename of the resulting key.
readonly OUTPUT_FILE="$DIR/ca.key.pem"

# We output the root key to "./ca/private" and expect this directory
# to be present.
if ! [ -d $DIR ]; then
  fatal "This script requires a $DIR directory to be present!"
fi

openssl genrsa \
  -aes256 \
  -out $OUTPUT_FILE \
  1024

chmod 400 $OUTPUT_FILE
