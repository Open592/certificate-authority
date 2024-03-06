#!/usr/bin/env bash

set -euo pipefail

# Log a message to stderr which includes the script's filename
#
# Example :: "./script-name.sh <MESSAGE>"
log() {
  echo "[${0##*/}]: $1" >&2;
}

# Log a fatal message before exiting
fatal() {
  log "<FATAL> $1";

  exit 1;
}

if ! [ -x "$(command -v openssl)" ]; then
  fatal "This script requires openssl to be installed!"
fi
