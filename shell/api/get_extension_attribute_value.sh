#!/bin/bash

EAID=extension_attribute_number
serial=""
username=""
password=""
xml=$(curl -u '${username}':'${password}' https://YOURJAMFPROSERVER/JSSResource/computers/serialnumber/${serial}/subset/extension_attributes)
value=$(echo $xml | xpath "//*[id=$EAID]/value/text()" 2>/dev/null)
echo $value
