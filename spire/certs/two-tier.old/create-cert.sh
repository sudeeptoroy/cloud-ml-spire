#!/usr/bin/env bash

BASEDIR=$(dirname "$0")

# Create a directory structure for the root CA and intermediate CA
mkdir -p ${BASEDIR}/root-ca/private ${BASEDIR}/root-ca/newcerts ${BASEDIR}/intermediate-ca/private ${BASEDIR}/intermediate-ca/newcerts

# Generate the root CA key pair and certificate
openssl genrsa -out ${BASEDIR}/root-ca/private/cakey.pem 2048
openssl req -new -x509 -key ${BASEDIR}/root-ca/private/cakey.pem -out ${BASEDIR}/root-ca/cacert.pem -days 3650 -config openssl.cnf

# Generate the intermediate CA key pair and certificate 

openssl genrsa -out ${BASEDIR}/intermediate-ca/private/intermediatekey.pem 2048
openssl req -new -key ${BASEDIR}/intermediate-ca/private/intermediatekey.pem -out ${BASEDIR}/intermediate-ca/csr.pem -config openssl.cnf
openssl ca -extensions my_policy -days 3650 -notext -md sha256 -in ${BASEDIR}/intermediate-ca/csr.pem -out ${BASEDIR}/intermediate-ca/cert.pem -cert ${BASEDIR}/root-ca/cacert.pem -keyfile ${BASEDIR}/root-ca/private/cakey.pem -config openssl.cnf

# Create a certificate chain file
cat ${BASEDIR}/intermediate-ca/cert.pem ${BASEDIR}/root-ca/cacert.pem > ${BASEDIR}/intermediate-ca/ca-chain.pem

# You can now use the ca-chain.pem file to sign your server certificates
echo "ca-chain here"
echo "${BASEDIR}/intermediate-ca/ca-chain.pem"
