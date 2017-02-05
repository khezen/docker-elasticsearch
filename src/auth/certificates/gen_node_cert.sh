#!/bin/bash

node_name=elasticsearch
ca_pwd=$1
ks_pwd=$2

rm -f $node_name-keystore.jks
rm -f $node_name.csr
rm -f $node_name-signed.pem

echo Generating keystore and certificate for node $node_name

keytool -genkey \
        -alias     $node_name \
        -keystore  $node_name-keystore.jks \
        -keyalg    RSA \
        -keysize   2048 \
        -validity  712 \
        -sigalg SHA256withRSA \
        -keypass $ks_pwd \
        -storepass $ks_pwd \
        -dname "CN=$node_name, OU=SSL, C=COM" \
        -ext san=dns:$node_name,dns:localhost,ip:127.0.0.1,oid:1.2.3.4.5.5

#oid:1.2.3.4.5.5 denote this a server node certificate for search guard

echo Generating certificate signing request for node $node_name

keytool -certreq \
        -alias      $node_name \
        -keystore   $node_name-keystore.jks \
        -file       $node_name.csr \
        -keyalg     rsa \
        -keypass $ks_pwd \
        -storepass $ks_pwd \
        -dname "CN=$node_name, OU=SSL, C=COM" \
        -ext san=dns:$node_name,dns:localhost,ip:127.0.0.1,oid:1.2.3.4.5.5

#oid:1.2.3.4.5.5 denote this a server node certificate for search guard

echo Sign certificate request with CA
openssl ca \
    -in $node_name.csr \
    -notext \
    -out $node_name-signed.pem \
    -config etc/signing-ca.conf \
    -extensions v3_req \
    -batch \
	-passin pass:$ca_pwd \
	-extensions server_ext

echo "Import back to keystore (including CA chain)"

cat ca/chain-ca.pem $node_name-signed.pem | keytool \
    -importcert \
    -keystore $node_name-keystore.jks \
    -storepass $ks_pwd \
    -noprompt \
    -alias $node_name

keytool -importkeystore -srckeystore $node_name-keystore.jks -srcstorepass $ks_pwd -srcstoretype JKS -deststoretype PKCS12 -deststorepass $ks_pwd -destkeystore $node_name-keystore.p12

echo All done for $node_name
