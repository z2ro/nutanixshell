#!/bin/bash

#read -p "TEMPLATE-" NAME_TEMPLATE

curl --insecure --silent --request GET https://x.x.x.x:9440/PrismGateway/services/rest/v2.0/images --header 'authorization: Basic auth' 2>&1 | tr '},{' '\n' | grep -n1 TEMPLATE-$1 | grep uuid | tr '":"' ' ' | awk '{print $3}'
