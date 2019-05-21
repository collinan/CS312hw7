Author: Andrew Collins

Name of Shell script: hw7.sh
Name of Ansible Playbook: webserver.yaml

Running my program:
1)Start up pfSense router, CentOS CLI VM and 4 seperate Alpine VMs
	Note: record the IP addresses of each VM
2)On the CentOS CLI VM:
	a)install ansible "sudo yum install -y ansible"
	b)change the permission for hw7.sh, "chmod 700 hw7.sh
	c) run "./hw7.sh" , it will ask you to enter the IP addresses
	  of each Alpine machine
	d)follow the on screen promts
