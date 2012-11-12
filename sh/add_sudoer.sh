#!/bin/bash
#
#This script adds the current user to /etc/sudoers file
#and gives the current user root privilegs

result=-1

#while [ $result -ne 0 ] && [ $result -ne 1 ]
#do:
	currentuser=$USER
	su -c "echo '$currentuser ALL=(ALL) ALL' >> /etc/sudoers"
	result=$?
#done
