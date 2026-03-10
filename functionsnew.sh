#!/bin/bash

USERID=$(id -u)
if [ $USERID -ne 0 ]
    then
    echo "ERROR: Please run with root access"
    exit 1
    else
    echo "You are with root access"
fi

dnf list installed mysql
if [ $? -ne 0 ]
then
echo "MySQL is going to install"
dnf install mysql -y
VALIDATE $? "MySql"
else
echo "MYSQL is already installed"
fi

dnf list installed nginx
if [ $? -ne 0 ]
then
echo "nginx is going to install"
dnf install nginx -y
VALIDATE $? "nginx"
else
echo "nginx is already installed"
fi

dnf list installed python3
if [ $? -ne 0 ]
then
echo "python3 is going to install"
dnf install python3 -y
VALIDATE $? "python3"
else
echo "python3 is already installed"
fi

VALIDATE()
{
    if [ $1 -eq 0 ]
    then
    echo "$2 is successfully installed"
    else
    echo "FAILURE: $2 is failed"
    exit 1
    fi
}