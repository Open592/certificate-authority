#!/usr/bin/env bash

source ./scripts/shared.sh

assert_directory_exists $KEYSTORE_DIR
assert_directory_exists $CA_INTERMEDIATE_PRIVATE_DIR
assert_directory_exists $CA_INTERMEDIATE_CERTS_DIR

if ! [ -x "$(command -v keytool)" ]; then
  fatal "This script requires keytool to be installed!"
fi

openssl pkcs12 \
  -export \
  -in "$CA_INTERMEDIATE_CERTS_DIR/jagex-ltd.cert.pem" \
  -inkey "$CA_INTERMEDIATE_PRIVATE_DIR/jagex-ltd.key.pem" \
  -name "jagex" \
  -certfile "$CA_INTERMEDIATE_CERTS_DIR/intermediate.cert.pem" \
  -caname "thawte" \
  -out "$KEYSTORE_DIR/jagex-keystore.pkcs12"

keytool -importkeystore \
  -destkeystore "$KEYSTORE_DIR/jagex-keystore.jks" \
  -srckeystore "$KEYSTORE_DIR/jagex-keystore.pkcs12" \
  -srcstoretype PKCS12

keytool -list \
  -v \
  -keystore "$KEYSTORE_DIR/jagex-keystore.jks"
