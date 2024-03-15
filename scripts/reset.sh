#!/usr/bin/env bash

source ./scripts/shared.sh

# Delete the following files which are created during certificate creation.
readonly FILE_GLOBS=(
  "$CA_ROOT_DIR/index.txt*" # Cover "index.txt", "index.txt.attr", "index.txt.old"
  "$CA_ROOT_DIR/serial*" # Cover "serial", "serial.old", etc
  "$CA_ROOT_CERTS_DIR/ca.cert.pem"
  "$CA_INTERMEDIATE_DIR/index.txt*"
  "$CA_INTERMEDIATE_DIR/serial*"
  "$CA_INTERMEDIATE_CERTS_DIR/*.pem"
  "$CA_INTERMEDIATE_CSR_DIR/intermediate.csr.pem"
  "$CA_INTERMEDIATE_PRIVATE_DIR/*.key.pem"
  "$CA_ROOT_NEWCERTS_DIR/*.pem"
  "$CA_ROOT_PRIVATE_DIR/ca.key.pem"
  "$KEYSTORE_DIR/*"
)

for glob in ${FILE_GLOBS[@]}; do
  rm -f -v $glob
done

# Create the required files
touch "$CA_ROOT_DIR/index.txt"
touch "$CA_INTERMEDIATE_DIR/index.txt"

# For the next run we want the intermediate certificate to use the serial
# present within the original Thawte certificate
echo "0a" > "$CA_ROOT_DIR/serial"
echo "4F00F6A4A7353212DBE4F2B78B897B38" > "$CA_INTERMEDIATE_DIR/serial"
