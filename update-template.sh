#!/bin/bash
# Satoshi

echo "1)CENTOS7 2)UBUNTU18 3)UBUNTU20"
read -p "Choose your destiny: " CYD

declare -a CENTOS7=( "'sudo yum update -y'" "./image_centos7_update.log" )
declare -a UBUNTU18=( "'sudo apt upgrade && sudo apt update -y'" "./image_ubuntu18_update.log" )
declare -a UBUNTU20=( "'sudo apt upgrade && sudo apt update -y'" "./image_ubuntu20_update.log" )
UUID=$(bash get-template-uuid.sh $CYD)
CYD2=$CYD[0]
CYD3=$CYD[1]

read -p "VM IP: " VM_IP
read -p "VM User: " VM_USER
read -sp "Password: " VM_PASS
echo
read -p "Container: " T_CONTAINER
echo
echo "Acessando a VM e atualizando"
echo $VM_PASS | ssh -tt $VM_USER@$VM_IP "${!CYD2}" >> "${!CYD3}"
echo "Apagando a imagem atual $CYD ..."
curl --insecure --request DELETE --url https://$1:9440/api/nutanix/v2.0/images/$UUID --header "'authorization: Basic $2'"
echo
sleep 5
echo "Aguarde..."
echo
echo "Criando imagem nova $CYD ..."
curl --insecure --request POST --url https://$1:9440/api/nutanix/v2.0/images/ --header "'authorization: Basic $2'" --header 'content-type: application/json' --data '{"image_import_spec": {"container_name": "string","url": "nfs://127.0.0.1/CONTAINER/.acropolis/vmdisk/uuid"},"image_type": "DISK_IMAGE","name": "TEMPLATE-NAME"}'
