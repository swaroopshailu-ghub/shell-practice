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

VALIDATE()
{
    if [ $1 -eq 0 ]
    then
    echo "$2 is successfully installed"
    else
    echo "FAILURE: $2 is failed"
    exit 1
}