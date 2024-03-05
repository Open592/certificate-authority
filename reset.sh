#!/usr/bin/env bash

set -euo pipefail

# Delete the following files which are created during certificate creation.
readonly FILES_GLOBS=(
  "./ca/index.txt*" # Cover "index.txt", "index.txt.attr", "index.txt.old"
  "./ca/serial*" # Cover "serial", "serial.old", etc
  "./ca/certs/ca.cert.pem"
  "./ca/intermediate/certs/*.pem"
  "./ca/intermediate/certs/*.pem"
  "./ca/intermediate/csr/intermediate.csr.pem"
  "./ca/intermediate/private/intermediate.key.pem"
  "./ca/newcerts/*.pem"
  "./ca/private/ca.key.pem"
)

for file in ${FILES_GLOBS[@]}; do
  rm -f -v $file
done

# Create the required files

touch "./ca/index.txt"

# For the next run we want the intermediate certificate to use the serial
# present within the original Thawte certificate
echo "0a" > "./ca/serial"
