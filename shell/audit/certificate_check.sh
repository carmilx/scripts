#!/bin/bash

CERTNAME="ISRG Root X1"

result="No"
## Default result. Gets changed to "Yes" if the Root CA is found

while read cert_entry; do
    if [ "$cert_entry" == "$CERTNAME" ]; then
        result="Yes"      
    fi

done < <(security find-certificate -a /System/Library/Keychains/SystemRootCertificates.keychain | /usr/bin/awk -F'"' '/alis/{print $4}')

if [ "$result" == "No" ]; then
    echo "<result>$result</result>" 
    exit 1
else
    echo "<result>$result</result>"
    exit 0
fi