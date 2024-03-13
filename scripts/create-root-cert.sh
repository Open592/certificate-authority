#!/usr/bin/env bash

source ./scripts/shared.sh

# Directory where we will output the resulting certificate.
assert_directory_exists $CA_ROOT_CERTS_DIR

openssl req \
  -config $ROOT_CONFIGURATION_FILE \
  -key "$CA_ROOT_PRIVATE_DIR/ca.key.pem" \
  -new \
  -subj "/C=ZA/ST=Western Cape/L=Cape Town/O=Thawte Consulting cc/OU=Certification Services Division/CN=Thawte Premium Server CA/emailAddress=premium-server@thawte.com" \
  -x509 \
  -days 7300 \
  -out "$CA_ROOT_CERTS_DIR/ca.cert.pem"

chmod 444 "$CA_ROOT_CERTS_DIR/ca.cert.pem"

openssl x509 -noout -text -in "$CA_ROOT_CERTS_DIR/ca.cert.pem"
