#!/usr/bin/env bash

source shared.sh

assert_directory_exists $CA_ROOT_PRIVATE_DIR

# Filename of the resulting key.
readonly ROOT_KEY_FILE="$CA_ROOT_PRIVATE_DIR/ca.key.pem"

openssl genrsa \
  -aes256 \
  -out $ROOT_KEY_FILE \
  1024

chmod 400 $ROOT_KEY_FILE
