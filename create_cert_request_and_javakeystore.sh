#!/bin/bash

#Usage: run the script with a paramater of the subject name. 
#
#Example: "create_cert_request_and_javakeystore.sh myserver.acme.com"
#
#Note: the "keytool_path" variable is hard coded and needs to be updated if java is located somewhere else
#

#Required
domain=$1
commonname=$domain

#Replace with your company details and patch to java
country=US
state=Arizone
locality=Tempe
organization="ACME\, Inc"
organizationalunit=IT
email=IT@ACME.com
keytool_path=/usr/java/latest/bin/

#Optional
password=changeit

if [ -z "$domain" ]
then
    echo "Argument not present."
    echo "Useage $0 [common name]"

    exit 99
fi

echo "Generating key request in keystore for $domain: $keytool_path"keytool" -genkey -dname "cn=$domain, ou=$organizationalunit, O=$organization, l=$locality, st=$state, c=$country -alias $domain" -keysize 2048 -keyalg RSA keypass $password -keystore $domain.jks -storepass $password"
#Generate a key
$keytool_path"keytool" -genkey -dname "CN=$domain, OU=$organizationalunit, O=$organization, L=$locality, ST=$state, C=$country" -alias $domain -keysize 2048 -keyalg RSA -keypass $password -keystore $domain.jks -storepass $password

#Create the request
echo "Creating CSR:   $keytool_path"keytool" -certreq -keyalg RSA -alias $domain -file $domain.csr -keystore $domain.jks -keypass $password -storepass $password"
$keytool_path"keytool" -certreq -keyalg RSA -alias $domain -file $domain.csr -keystore $domain.jks -keypass $password -storepass $password





