#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "ERROR: Please run this script with root user"
    exit 1
else
    echo "You're wuth root access"
fi

dnf list installed mqsql
if [ $? -ne 0 ]
then
    echo "MYSQL : going to install"
    dnf install mysql -y
    if [ $? -eq 0 ]
    then
    echo "MQSQL installed Successfully"
    else
    echo "FAILURE: MYSQL failed."
    exit 1
    fi
else
    echo "MYSQL is already installed"
    exit 1
fi


