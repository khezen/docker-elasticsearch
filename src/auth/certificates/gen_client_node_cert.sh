#!/bin/bash

client_name=$1
ca_pwd=$2
ks_pwd=$3

echo Generating keystore and certificate for node $client_name

keytool -genkey \
        -alias     $client_name \
        -keystore  $client_name-keystore.jks \
        -keyalg    RSA \
        -keysize   2048 \
        -sigalg SHA256withRSA \
        -validity  712 \
        -keypass $ks_pwd \
        -storepass $ks_pwd \
        -dname "CN=$client_name, OU=devops, C=COM"

echo Generating certificate signing request for node $client_name

keytool -certreq \
        -alias      $client_name \
        -keystore   $client_name-keystore.jks \
        -file       $client_name.csr \
        -keyalg     rsa \
        -keypass $ks_pwd \
        -storepass $ks_pwd \
        -dname "CN=$client_name, OU=devops, C=COM"

echo Sign certificate request with CA
openssl ca \
    -in $client_name.csr \
    -notext \
    -out $client_name-signed.pem \
    -config etc/signing-ca.conf \
    -extensions v3_req \
    -batch \
	-passin pass:$CA_PWD \
	-extensions server_ext

echo "Import back to keystore (including CA chain)"

cat ca/chain-ca.pem $client_name-signed.pem | keytool \
    -importcert \
    -keystore $client_name-keystore.jks \
    -storepass $ks_pwd \
    -noprompt \
    -alias $client_name

keytool -importkeystore -srckeystore $client_name-keystore.jks -srcstorepass $ks_pwd -srcstoretype JKS -deststoretype PKCS12 -deststorepass $ks_pwd -destkeystore $client_name-keystore.p12

openssl pkcs12 -in "$client_name-keystore.p12" -out "$client_name.all.pem" -nodes -passin "pass:$ks_pwd"
openssl pkcs12 -in "$client_name-keystore.p12" -out "$client_name.key.pem" -nocerts -nodes -passin pass:$ks_pwd
openssl pkcs12 -in "$client_name-keystore.p12" -out "$client_name.crt.pem" -clcerts -nokeys -passin pass:$ks_pwd
cat "$client_name.crt.pem" ca/chain-ca.pem  > "$client_name.crtfull.pem"

echo All done for $client_name
