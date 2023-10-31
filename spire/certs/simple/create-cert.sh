#!/usr/bin/env bash

BASEDIR=$(dirname "$0")
TRUSTDOMAIN=${1:-"example.org"}

openssl req -new -x509 -days 365 -nodes -sha256 \
  -subj "/C=NL/O=SPIFFE/OU=SPIRE/CN=${TRUSTDOMAIN}" \
  -out "${BASEDIR}/${TRUSTDOMAIN}.pem" \
  -keyout "${BASEDIR}/${TRUSTDOMAIN}.key"
