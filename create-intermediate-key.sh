#!/usr/bin/env bash

source shared.sh

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
  1024

chmod 400 $OUTPUT_FILE
