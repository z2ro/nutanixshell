#!/bin/bash

read -p "VM NAME: " V_NAME
read -p "VCPU: " V_VCPU
read -p "MEM: " V_MEM

URL=https://$1:9440/api/nutanix/v3/vms

DATAC=$(cat DATA-VM.json | jq --compact-output '.')

DATAC1=$(echo $DATAC | jq --compact-output --arg a "$V_NAME" '.spec.name = $a')

DATAC2=$(echo $DATAC1 | jq --compact-output --arg a "$V_VCPU" '.spec.resources.num_sockets = $a')

DATAC3=$(echo $DATAC2 | jq --compact-output --arg a "$V_MEM" '.spec.resources.memory_size_mib = $a')

DATAC4=$(echo $DATAC3 | jq --compact-output --arg a "$V_MEM" '.spec.resources.memory_size_mib = $a')

echo -e "curl -v --insecure --request POST --url $URL --header 'content-type: application/json' --header 'authorization: Basic $2' --data "$DATAC4""
