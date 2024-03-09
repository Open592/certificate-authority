#!/usr/bin/env bash

source shared.sh

# Directory where we will output the resulting key.
assert_directory_exists $CA_INTERMEDIATE_PRIVATE_DIR

# Filename of the resulting key.
readonly INTERMEDIATE_KEY_FILE="$CA_INTERMEDIATE_PRIVATE_DIR/jagex-ltd.key.pem"

openssl genrsa \
  -aes256 \
  -out $INTERMEDIATE_KEY_FILE \
  2048

chmod 400 $INTERMEDIATE_KEY_FILE
