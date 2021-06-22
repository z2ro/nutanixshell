#!/bin/bash

read -p "Nutanix IP: " NTX_IP
read -p "IP: " VM_IP
echo
echo "CENTOS7, UBUNTU18, UBUNTU20"
read -p "Choose your destiny: " CYD
echo

UUID=$(bash get-uuid.sh $CYD)

if [ $CYD == "CENTOS7" ]; then
    echo "Acessando a VM e atualizando"
    echo password | ssh -tt user@$VM_IP 'sudo yum update -y' >> ./image_centos7_update.log
    echo
    echo "Apagando a imagem atual $CYD ..."
    curl --insecure --request DELETE --url https://$NTX_IP:9440/api/nutanix/v2.0/images/$UUID --header 'authorization: Basic auth'
    echo
    sleep 5
    echo "Aguarde..."
    echo
    echo "Criando imagem nova $CYD ..."
    curl --insecure --request POST --url https://$NTX_IP:9440/api/nutanix/v2.0/images/ --header 'authorization: Basic auth' --header 'content-type: application/json' --data '{"image_import_spec": {"container_name": "string","url": "nfs://127.0.0.1/CONTAINER/.acropolis/vmdisk/uuid"},"image_type": "DISK_IMAGE","name": "TEMPLATE-NAME"}'
fi

if [ $CYD == "UBUNTU18" ]; then
    echo "Acessando a VM e atualizando"
    echo password | ssh -tt user@$VM_IP 'sudo apt upgrade && sudo apt update -y' >> ./image_ubuntu18_update.log
    echo
    echo "Apagando a imagem atual $CYD ..."
    curl --insecure --request DELETE --url https://$NTX_IP:9440/api/nutanix/v2.0/images/$UUID --header 'authorization: Basic auth'
    echo
    sleep 5
    echo "Aguarde..."
    echo
    echo "Criando imagem nova $CYD ..."
    curl --insecure --request POST --url https://$NTX_IP:9440/api/nutanix/v2.0/images/ --header 'authorization: Basic auth' --header 'content-type: application/json' --data '{"image_import_spec": {"container_name": "string","url": "nfs://127.0.0.1/CONTAINER/.acropolis/vmdisk/uuid"},"image_type": "DISK_IMAGE","name": "TEMPLATE-NAME"}'
fi

if [ $CYD == "UBUNTU20" ]; then
    echo "Acessando a VM e atualizando"
    echo password | ssh -tt user@$VM_IP 'sudo apt upgrade && sudo apt update -y' >> ./image_ubuntu20_update.log
    echo
    echo "Apagando a imagem atual $CYD ..."
    curl --insecure --request DELETE --url https://$NTX_IP:9440/api/nutanix/v2.0/images/$UUID --header 'authorization: Basic auth'
    echo
    sleep 5
    echo "Aguarde..."
    echo
    echo "Criando imagem nova $CYD ..."
    curl --insecure --request POST --url https://$NTX_IP:9440/api/nutanix/v2.0/images/ --header 'authorization: Basic auth' --header 'content-type: application/json' --data '{"image_import_spec": {"container_name": "string","url": "nfs://127.0.0.1/CONTAINER/.acropolis/vmdisk/uuid"},"image_type": "DISK_IMAGE","name": "TEMPLATE-NAME"}'
fi
