#!/usr/bin/env bash

source shared.sh

assert_directory_exists $CA_ROOT_NEWCERTS_DIR
assert_directory_exists $CA_ROOT_CERTS_DIR

assert_directory_exists $CA_INTERMEDIATE_CSR_DIR
assert_directory_exists $CA_INTERMEDIATE_CERTS_DIR

# Create the CSR
openssl req \
  -config $INTERMEDIATE_CONFIGURATION_FILE \
  -new \
  -key "$CA_INTERMEDIATE_PRIVATE_DIR/intermediate.key.pem" \
  -out "$CA_INTERMEDIATE_CSR_DIR/intermediate.csr.pem"

# Create the certificate
openssl ca \
  -config $ROOT_CONFIGURATION_FILE \
  -extensions v3_intermediate_ca \
  -notext \
  -in "$CA_INTERMEDIATE_CSR_DIR/intermediate.csr.pem" \
  -out "$CA_INTERMEDIATE_CERTS_DIR/intermediate.cert.pem"

openssl x509 \
  -noout \
  -text \
  -in "$CA_INTERMEDIATE_CERTS_DIR/intermediate.cert.pem"

openssl verify \
  -no_check_time \
  -CAfile "$CA_ROOT_CERTS_DIR/ca.cert.pem" \
  "$CA_INTERMEDIATE_CERTS_DIR/intermediate.cert.pem"

# Create certificate chain
cat "$CA_INTERMEDIATE_CERTS_DIR/intermediate.cert.pem" "$CA_ROOT_CERTS_DIR/ca.cert.pem" \
  > "$CA_INTERMEDIATE_CERTS_DIR/ca-chain.cert.pem"

chmod 444 "$CA_INTERMEDIATE_CERTS_DIR/ca-chain.cert.pem"
