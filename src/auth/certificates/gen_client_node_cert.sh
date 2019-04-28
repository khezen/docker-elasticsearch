#!/bin/bash

gen_client_node_cert(){
    local client_name=$1

    echo Generating keystore and certificate for node $client_name

    keytool -genkey \
            -alias     $client_name \
            -keystore  $client_name-keystore.jks \
            -keyalg    RSA \
            -keysize   2048 \
            -sigalg SHA256withRSA \
            -validity  712 \
            -keypass $KS_PWD \
            -storepass $KS_PWD \
            -dname "CN=$client_name, OU=devops, C=COM"

    echo Generating certificate signing request for node $client_name

    keytool -certreq \
            -alias      $client_name \
            -keystore   $client_name-keystore.jks \
            -file       $client_name.csr \
            -keyalg     rsa \
            -keypass $KS_PWD \
            -storepass $KS_PWD \
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
        -storepass $KS_PWD \
        -noprompt \
        -alias $client_name

    keytool -importkeystore -srckeystore $client_name-keystore.jks -srcstorepass $KS_PWD -srcstoretype JKS -deststoretype PKCS12 -deststorepass $KS_PWD -destkeystore $client_name-keystore.p12

    openssl pkcs12 -in "$client_name-keystore.p12" -out "$client_name.all.pem" -nodes -passin "pass:$KS_PWD"
    openssl pkcs12 -in "$client_name-keystore.p12" -out "$client_name.key.pem" -nocerts -nodes -passin pass:$KS_PWD
    openssl pkcs12 -in "$client_name-keystore.p12" -out "$client_name.crt.pem" -clcerts -nokeys -passin pass:$KS_PWD
    cat "$client_name.crt.pem" ca/chain-ca.pem  > "$client_name.crtfull.pem"

    echo All done for $client_name
}

gen_client_node_cert $1
