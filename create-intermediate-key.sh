#!/usr/bin/env bash

source shared.sh

# We output the root key to $DIR and expect this directory
# to be present.
assert_directory_exists $CA_INTERMEDIATE_PRIVATE_DIR

# Filename of the resulting key.
readonly INTERMEDIATE_KEY_FILE="$CA_INTERMEDIATE_PRIVATE_DIR/intermediate.key.pem"

openssl genrsa \
  -aes256 \
  -out $INTERMEDIATE_KEY_FILE \
  1024

chmod 400 $INTERMEDIATE_KEY_FILE
