#Author: Andrew Collins
#!/bin/bash -e

echo -e "\nEnter the IP address of Alpine VM machines:\n"
read -p 'Alpine VM 1 IP: ' alpine1
read -p 'Alpine VM 2 IP: ' alpine2
read -p 'Alpine VM 3 IP: ' alpine3
read -p 'Alpine VM 4 IP: ' alpine4

echo -e "\nThe following IPs were entered:\n$alpine1 \n$alpine2 \n$alpine3 \n$alpine4"

echo -e "\n**********Building host file: hosts.ini**********\n"
touch hosts.ini
echo -e "[mynodes]\n$alpine1\n$alpine2\n$alpine3\n$alpine4\n" > hosts.ini
echo -e "[mynodes:vars]" >> hosts.ini
echo -e "ansible_connection=ssh" >> hosts.ini
echo -e "ansible_port=22" >> hosts.ini
echo -e "ansible_user=root" >> hosts.ini
echo -e "ansible_pythin_interpreter=/usr/bin/python3" >> hosts.ini



echo -e "\n**********Generate SSH key**********\n"
ssh-keygen -t rsa


echo -e "\n**********Copying SSH keys to VM**********\n"

echo -e "Copying RSA key to:$alpine1 "
ssh-copy-id -i ~/.ssh/id_rsa root@$alpine1
if [ $? -ne 0 ]
then
echo -e "Copying RSA key to $alpine1 failed" 
exit 1
fi


echo -e "Copying RSA key to:$alpine2 "
ssh-copy-id -i ~/.ssh/id_rsa root@$alpine2
if [ $? -ne 0 ]
then
echo -e "Copying RSA key to $alpine2 failed" 
exit 1
fi


echo -e "Copying RSA key to:$alpine3"
ssh-copy-id -i ~/.ssh/id_rsa root@$alpine3
if [ $? -ne 0 ]
then
echo -e "Copying RSA key to $alpine3 failed" 
exit 1
fi


echo -e "Copying RSA key to:$alpine4 "
ssh-copy-id -i ~/.ssh/id_rsa root@$alpine4
if [ $? -ne 0 ]
then
echo -e "Copying RSA key to $alpine4 failed" 
exit 1
fi


echo -e "\n**********Running Ansible playbook**********\n"
ansible-playbook webserver.yaml -i ./hosts.ini


echo -e "\n**********Setup complete**********\n"

curl $alpine1
curl $alpine2
curl $alpine3
curl $alpine4
