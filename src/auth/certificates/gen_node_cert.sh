#!/bin/bash

gen_node_cert(){
    rm -f $NODE_NAME-keystore.jks
    rm -f $NODE_NAME.csr
    rm -f $NODE_NAME-signed.pem

    echo Generating keystore and certificate for node $NODE_NAME

    keytool -genkey \
            -alias     $NODE_NAME \
            -keystore  $NODE_NAME-keystore.jks \
            -keyalg    RSA \
            -keysize   2048 \
            -validity  712 \
            -sigalg    SHA256withRSA \
            -keypass   $KS_PWD \
            -storepass $KS_PWD \
            -dname "CN=$NODE_NAME, OU=SSL, C=COM" \
            -ext san=dns:$NODE_NAME,dns:localhost,ip:127.0.0.1,oid:1.2.3.4.5.5

    #oid:1.2.3.4.5.5 denote this a server node certificate for search guard

    echo Generating certificate signing request for node $NODE_NAME

    keytool -certreq \
            -alias      $NODE_NAME \
            -keystore   $NODE_NAME-keystore.jks \
            -file       $NODE_NAME.csr \
            -keyalg     rsa \
            -keypass $KS_PWD \
            -storepass $KS_PWD \
            -dname "CN=$NODE_NAME, OU=SSL, C=COM" \
            -ext san=dns:$NODE_NAME,dns:localhost,ip:127.0.0.1,oid:1.2.3.4.5.5

    #oid:1.2.3.4.5.5 denote this a server node certificate for search guard

    echo Sign certificate request with CA
    openssl ca \
        -in $NODE_NAME.csr \
        -notext \
        -out $NODE_NAME-signed.pem \
        -config etc/signing-ca.conf \
        -extensions v3_req \
        -batch \
        -passin pass:$CA_PWD \
        -extensions server_ext

    echo "Import back to keystore (including CA chain)"

    cat ca/chain-ca.pem $NODE_NAME-signed.pem | keytool \
        -importcert \
        -keystore $NODE_NAME-keystore.jks \
        -storepass $KS_PWD \
        -noprompt \
        -alias $NODE_NAME

    keytool -importkeystore -srckeystore $NODE_NAME-keystore.jks -srcstorepass $KS_PWD -srcstoretype JKS -deststoretype PKCS12 -deststorepass $KS_PWD -destkeystore $NODE_NAME-keystore.p12

    echo All done for $NODE_NAME
}

gen_node_cert

