#!/bin/bash

# Obatains serial number
serial=$(system_profiler SPHardwareDataType | grep 'Serial Number (system)' | awk '{print $NF}')

# Sets value of the extension attribute 
EAID=EXTENSION_Attribute_Value

#Queries Jamf for machine info via API
xml=$(curl -u 'APIUSER':'APIPASSWORD' https://YOURJAMFPROSERVER/JSSResource/computers/serialnumber/$serial/subset/extension_attributes)

# Filters XML and obtains EA value
value=$(echo $xml | xpath "//*[id=$EAID]/value/text()" 2>/dev/null)


# Preferences are case sensitive
# Set Machinename
scutil --set HostName $value
scutil --set LocalHostName $value
scutil --set ComputerName $value