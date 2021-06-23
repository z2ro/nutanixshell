#!/bin/bash

read -p "Nutanix IP: " P_VIP
read -p "User: " U_USER0
read -sp "Password: " U_PASSWORD

U_USER1=$(echo $U_USER0 | base64)

x="nutanix"
menu ()
{
while true $x != "nutanix"
do
clear
echo "================================================"
echo "Nutanix Shell"
echo 
echo "1) Create VM"
echo
echo "2) Update template"
echo 
echo "================================================"

read -p "Digite a opção desejada: " x
echo "Opção informada ($x)"
echo "================================================"

case "$x" in

    1)
      ./create-vm.sh $P_VIP $U_USER1
      sleep 5

echo "================================================"
;;
    2)
      ./update-template.sh
      sleep 5

echo "================================================"
 ;;
       3)
         echo "saindo..."
         sleep 5
         clear;
         exit;
echo "================================================"
;;

*)
        echo "Opção inválida!"
esac
done

}
menu
