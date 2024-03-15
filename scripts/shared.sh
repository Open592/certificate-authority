#!/usr/bin/env bash

set -euo pipefail

# Log a message to stderr which includes the script's filename
#
# Example :: "./script-name.sh <MESSAGE>"
function log {
  echo "[${0##*/}]: $1" >&2;
}

# Log a fatal message before exiting
function fatal {
  log "<FATAL> $1";

  exit 1;
}

if ! [ -x "$(command -v openssl)" ]; then
  fatal "This script requires openssl to be installed!"
fi

readonly ROOT_DIR="$(pwd)"

readonly CA_ROOT_DIR="$ROOT_DIR/ca"
readonly KEYSTORE_DIR="$ROOT_DIR/keystore"

readonly CA_ROOT_CERTS_DIR="$CA_ROOT_DIR/certs"
readonly CA_ROOT_NEWCERTS_DIR="$CA_ROOT_DIR/newcerts"
readonly CA_ROOT_PRIVATE_DIR="$CA_ROOT_DIR/private"

readonly CA_INTERMEDIATE_DIR="$CA_ROOT_DIR/intermediate"
readonly CA_INTERMEDIATE_CERTS_DIR="$CA_INTERMEDIATE_DIR/certs"
readonly CA_INTERMEDIATE_CSR_DIR="$CA_INTERMEDIATE_DIR/csr"
readonly CA_INTERMEDIATE_NEWCERTS_DIR="$CA_INTERMEDIATE_DIR/newcerts"
readonly CA_INTERMEDIATE_PRIVATE_DIR="$CA_INTERMEDIATE_DIR/private"

readonly ROOT_CONFIGURATION_FILE="./conf/root-openssl.cnf"
readonly INTERMEDIATE_CONFIGURATION_FILE="./conf/intermediate-openssl.cnf"

function assert_directory_exists {
  if ! [ -d $1 ]; then
    fatal "This script requires a $1 directory to be present!"
  fi
}

assert_directory_exists $CA_ROOT_DIR

# We assume we are executing at the root of the directory structure
# and that we have a `ca/` directory at the same level.
#
# We set the following environment variable which specifies where
# openssl should be storing / finding it's required files.
#
# This environment variable is referenced within the configuration file.
export OPEN592_CA_ROOT_DIR="$CA_ROOT_DIR"
