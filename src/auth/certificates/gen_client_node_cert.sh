#!/bin/bash

CLIENT_NAME=$1

echo Generating keystore and certificate for node $CLIENT_NAME

keytool -genkey \
        -alias     $CLIENT_NAME \
        -keystore  $CLIENT_NAME-keystore.jks \
        -keyalg    RSA \
        -keysize   2048 \
        -sigalg SHA256withRSA \
        -validity  712 \
        -keypass $KS_PWD \
        -storepass $KS_PWD \
        -dname "CN=$CLIENT_NAME, OU=devops, C=COM"

echo Generating certificate signing request for node $CLIENT_NAME

keytool -certreq \
        -alias      $CLIENT_NAME \
        -keystore   $CLIENT_NAME-keystore.jks \
        -file       $CLIENT_NAME.csr \
        -keyalg     rsa \
        -keypass $KS_PWD \
        -storepass $KS_PWD \
        -dname "CN=$CLIENT_NAME, OU=devops, C=COM"

echo Sign certificate request with CA
openssl ca \
    -in $CLIENT_NAME.csr \
    -notext \
    -out $CLIENT_NAME-signed.pem \
    -config etc/signing-ca.conf \
    -extensions v3_req \
    -batch \
	-passin pass:$CA_PWD \
	-extensions server_ext 

echo "Import back to keystore (including CA chain)"

cat ca/chain-ca.pem $CLIENT_NAME-signed.pem | keytool \
    -importcert \
    -keystore $CLIENT_NAME-keystore.jks \
    -storepass $KS_PWD \
    -noprompt \
    -alias $CLIENT_NAME

keytool -importkeystore -srckeystore $CLIENT_NAME-keystore.jks -srcstorepass $KS_PWD -srcstoretype JKS -deststoretype PKCS12 -deststorepass $KS_PWD -destkeystore $CLIENT_NAME-keystore.p12

openssl pkcs12 -in "$CLIENT_NAME-keystore.p12" -out "$CLIENT_NAME.all.pem" -nodes -passin "pass:$KS_PWD"
openssl pkcs12 -in "$CLIENT_NAME-keystore.p12" -out "$CLIENT_NAME.key.pem" -nocerts -nodes -passin pass:$KS_PWD
openssl pkcs12 -in "$CLIENT_NAME-keystore.p12" -out "$CLIENT_NAME.crt.pem" -clcerts -nokeys -passin pass:$KS_PWD
cat "$CLIENT_NAME.crt.pem" ca/chain-ca.pem  > "$CLIENT_NAME.crtfull.pem"

echo All done for $CLIENT_NAME