#!/bin/bash

gen_root_ca(){
    rm -rf ca certs* crl *.jks

    mkdir -p ca/root-ca/private ca/root-ca/db crl certs
    chmod 700 ca/root-ca/private

    cp /dev/null ca/root-ca/db/root-ca.db
    cp /dev/null ca/root-ca/db/root-ca.db.attr
    echo 01 > ca/root-ca/db/root-ca.crt.srl
    echo 01 > ca/root-ca/db/root-ca.crl.srl

    echo 1
    echo $CA_PWD

    openssl req -new \
        -config etc/root-ca.conf \
        -out ca/root-ca.csr \
        -keyout ca/root-ca/private/root-ca.key \
        -batch \
        -passout pass:$CA_PWD

    openssl ca -selfsign \
        -config etc/root-ca.conf \
        -in ca/root-ca.csr \
        -out ca/root-ca.crt \
        -extensions root_ca_ext \
        -batch \
        -passin pass:$CA_PWD
        
    echo Root CA generated
        
    mkdir -p ca/signing-ca/private ca/signing-ca/db crl certs
    chmod 700 ca/signing-ca/private

    cp /dev/null ca/signing-ca/db/signing-ca.db
    cp /dev/null ca/signing-ca/db/signing-ca.db.attr
    echo 01 > ca/signing-ca/db/signing-ca.crt.srl
    echo 01 > ca/signing-ca/db/signing-ca.crl.srl

    openssl req -new \
        -config etc/signing-ca.conf \
        -out ca/signing-ca.csr \
        -keyout ca/signing-ca/private/signing-ca.key \
        -batch \
        -passout pass:$CA_PWD
        
    openssl ca \
        -config etc/root-ca.conf \
        -in ca/signing-ca.csr \
        -out ca/signing-ca.crt \
        -extensions signing_ca_ext \
        -batch \
        -passin pass:$CA_PWD
        
    echo Signing CA generated

    openssl x509 -in ca/root-ca.crt -out ca/root-ca.pem -outform PEM
    openssl x509 -in ca/signing-ca.crt -out ca/signing-ca.pem -outform PEM
    cat ca/signing-ca.pem ca/root-ca.pem > ca/chain-ca.pem

    #http://stackoverflow.com/questions/652916/converting-a-java-keystore-into-pem-format

    cat ca/root-ca.pem | keytool \
        -import \
        -v \
        -keystore truststore.jks   \
        -storepass $TS_PWD  \
        -noprompt -alias root-ca-chain
}

gen_root_ca

