#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "ERROR: Please run this script with root user"
    exit 1
else
    echo "You are with root access"
fi

dnf list installed mysql
# check already installed or not
if [ $? -ne 0 ]
then
    echo "MYSQL : going to install"
    dnf install mysql -y
    
    VALIDATE $? "MySQL"

else
    echo "MYSQL is already installed"
    exit 1
fi

dnf list installed python3
# check already installed or not
if [ $? -ne 0 ]
then
    echo "python3 : going to install"
    dnf install python3 -y
    
    VALIDATE $? "python3"

else
    echo "python3 is already installed"
    exit 1
fi

dnf list installed nginx
# check already installed or not
if [ $? -ne 0 ]
then
    echo "nginx : going to install"
    dnf install nginx -y
    
    VALIDATE $? "nginx"

else
    echo "nginx is already installed"
    exit 1
fi


VALIDATE()
{
 if [ $1 -eq 0 ]
    then
        echo "$2 installed Successfully"
    else
        echo "FAILURE: MYSQL failed."
        exit 1
    fi
}