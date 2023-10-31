#!/usr/bin/env bash

#BASEDIR=$(dirname "$0")
BASEDIR=$(pwd -P)
CA=${BASEDIR}/ca

mkdir -p ${CA}

# Create the directory structure

cd ${CA}
mkdir -p certs crl newcerts private
chmod 700 private
touch index.txt
echo 1000 > serial

# prepare the config file
cp ${BASEDIR}/root-ca.cnf ${CA}/root-ca.cnf

# create root key
cd ${CA}
#openssl genrsa -aes256 -out private/ca.key.pem 4096
openssl genrsa -out private/ca.key.pem 2048
openssl pkcs8 -in private/ca.key.pem -topk8 -nocrypt -out private/ca.enckey.pem
chmod 400 private/ca.key.pem private/ca.enckey.pem

# Create the root certificate
openssl req -config root-ca.cnf -key private/ca.key.pem -new -x509 \
    -days 7300 -sha256 -extensions v3_ca -out certs/ca.cert.pem

chmod 444 certs/ca.cert.pem
# verify 
openssl x509 -noout -text -in certs/ca.cert.pem

# Prepare the intermediate directory

ICA=${CA}/intermediate
mkdir -p  ${ICA}

cd ${ICA}
mkdir certs crl csr newcerts private
chmod 700 private
touch index.txt
echo 1000 > serial

echo 1000 > crlnumber

# create intermediate key
cd ${CA}
#openssl genrsa -aes256 -out intermediate/private/intermediate.key.pem 4096
#openssl genrsa -out intermediate/private/intermediate.key.pem 2048
#openssl genpkey -algorithm RSA -out intermediate/private/intermediate.key.pem -pkeyopt rsa_keygen_bits:2048
openssl genrsa -out intermediate/private/intermediate.key.pem 2048
openssl pkcs8 -in intermediate/private/intermediate.key.pem -topk8 -nocrypt -out intermediate/private/intermediate.enckey.pem
chmod 400 intermediate/private/intermediate.key.pem intermediate/private/intermediate.enckey.pem

# Create the intermediate certificate
cp ${BASEDIR}/intermediate-ca.cnf ${ICA}
cd ${CA}

# csr
openssl req -config intermediate/intermediate-ca.cnf -new -sha256 \
    -key intermediate/private/intermediate.key.pem \
    -out intermediate/csr/intermediate.csr.pem

# cert
openssl ca -config root-ca.cnf -extensions v3_intermediate_ca \
    -days 3650 -notext -md sha256 -in intermediate/csr/intermediate.csr.pem \
    -out intermediate/certs/intermediate.cert.pem

chmod 444 intermediate/certs/intermediate.cert.pem

# varify 
openssl x509 -noout -text -in intermediate/certs/intermediate.cert.pem
openssl verify -CAfile certs/ca.cert.pem intermediate/certs/intermediate.cert.pem


# Create the certificate chain file

cat intermediate/certs/intermediate.cert.pem certs/ca.cert.pem > \
    intermediate/certs/ca-chain.cert.pem
chmod 444 intermediate/certs/ca-chain.cert.pem
