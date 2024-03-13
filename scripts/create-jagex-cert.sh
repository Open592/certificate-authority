#!/usr/bin/env bash

source ./scripts/shared.sh

assert_directory_exists $CA_INTERMEDIATE_CSR_DIR
assert_directory_exists $CA_INTERMEDIATE_CERTS_DIR
assert_directory_exists $CA_INTERMEDIATE_NEWCERTS_DIR

# Create the CSR
openssl req \
  -config $INTERMEDIATE_CONFIGURATION_FILE \
  -new \
  -subj "/CN=Jagex Ltd/OU=SECURE APPLICATION DEVELOPMENT/O=Jagex Ltd/L=Cambridge/ST=Cambridgeshire/C=GB" \
  -key "$CA_INTERMEDIATE_PRIVATE_DIR/jagex-ltd.key.pem" \
  -out "$CA_INTERMEDIATE_CSR_DIR/jagex-ltd.csr.pem"

# Create the certificate
openssl ca \
  -config $INTERMEDIATE_CONFIGURATION_FILE \
  -extensions usr_cert \
  -notext \
  -startdate "20080829000000Z" \
  -enddate "20100912235959Z" \
  -md "sha1" \
  -in "$CA_INTERMEDIATE_CSR_DIR/jagex-ltd.csr.pem" \
  -out "$CA_INTERMEDIATE_CERTS_DIR/jagex-ltd.cert.pem"

chmod 444 "$CA_INTERMEDIATE_CERTS_DIR/jagex-ltd.cert.pem"

openssl x509 \
  -noout \
  -text \
  -in "$CA_INTERMEDIATE_CERTS_DIR/jagex-ltd.cert.pem"

openssl verify \
  -no_check_time \
  -CAfile "$CA_INTERMEDIATE_CERTS_DIR/ca-chain.cert.pem" \
  "$CA_INTERMEDIATE_CERTS_DIR/jagex-ltd.cert.pem"
