#!/bin/bash

#!/bin/sh

apiUser="username"
apiPass="password"
jssURL="https://YOURJAMFPROSERVER:8443/"
ea_name="extension_attribute_name"
ea_value="extension_attribute_number"
serial=$(system_profiler SPHardwareDataType | grep 'Serial Number (system)' | awk '{print $NF}')

# Create xml
	cat << EOF > /private/tmp/ea.xml
<computer>
	<extension_attributes>
		<extension_attribute>
			<name>$ea_name</name>
			<value>$ea_value</value>
		</extension_attribute>
	</extension_attributes>
</computer>
EOF

## Upload the xml file
curl -sfku "${apiUser}":"${apiPass}" "${jssURL}/JSSResource/computers/serialnumber/${serial}/subset/extensionattributes" -T /private/tmp/ea.xml -X PUT
echo ${serial}