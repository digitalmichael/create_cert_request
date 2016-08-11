#!/bin/bash

#Usage: run the script with a paramater of the subject name. 
#
#Example: "create_cert_request.sh myserver.ACME.com"
#
#
#

#Required
domain=$1
commonname=$domain

#Replace with your company details

country=US
state=Arizona
locality=Tempe
organization="ACME, Inc"
organizationalunit=IT
email=IT@ACME.com


#Optional
password=dummypassword

if [ -z "$domain" ]
then
    echo "Argument not present."
    echo "Useage $0 [common name]"

    exit 99
fi

echo "Generating key request for $domain: openssl genrsa -des3 -passout pass:$password -out $domain.key 2048 -noout"

#Generate a key
openssl genrsa -des3 -passout pass:$password -out $domain.key 2048 -noout

#Remove passphrase from the key. Comment the line out to keep the passphrase
echo "Removing passphrase from key"
openssl rsa -in $domain.key -passin pass:$password -out $domain.key

#Create the request
echo "Creating CSR:   openssl req -new -key $domain.key -out $domain.csr -passin pass:$password -subj /CN=$commonname/OU=$organizationalunit/O=$organization/L=$locality/ST=$state/C=$country"

openssl req -new -key $domain.key -out $domain.csr -passin pass:$password -subj "/CN=$commonname/OU=$organizationalunit/O=$organization/L=$locality/ST=$state/C=$country"

echo " "
echo "Certificate keyfile created: $domain.key"
echo "Certificate request file created: $domain.csr"
echo ""
echo "---------------------------"
echo "-----Below is your CSR-----"
echo "---------------------------"
echo
cat $domain.csr

echo
echo "---------------------------"
echo "-----Below is your Key-----"
echo "---------------------------"
echo
cat $domain.key
