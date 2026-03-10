#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ $USERID -ne 0 ]
    then
    echo -e "$R ERROR: Please run with root access $N"
    exit 1
    else
    echo -e "$G You are with root access $N"
fi

dnf list installed mysql
if [ $? -ne 0 ]
then
echo "MySQL is going to install"
dnf install mysql -y
VALIDATE $? "MySql"
else
echo -e "$Y MYSQL is already installed $N"
fi

dnf list installed nginx
if [ $? -ne 0 ]
then
echo "nginx is going to install"
dnf install nginx -y
VALIDATE $? "nginx"
else
echo -e "$Y nginx is already installed $N"
fi

dnf list installed python3
if [ $? -ne 0 ]
then
echo "python3 is going to install"
dnf install python3 -y
VALIDATE $? "python3"
else
echo -e "$Y python3 is already installed $N"
fi

VALIDATE()
{
    if [ $1 -eq 0 ]
    then
    echo -e "$2 is $G successfully installed $N"
    else
    echo -e "$R FAILURE: $2 is failed $N"
    exit 1
    fi
}