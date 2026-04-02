#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOGS_FOLDER="/var/log/shellscript-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"
PACKAGES=("nginx" "python3" "mysql" "httpd")

mkdir -p $LOGS_FOLDER
echo "Script started executing at: $(date)" | tee -a $LOG_FILE

if [ $USERID -ne 0 ]
then
echo -e "$R ERROR: Please run with root access $N" | tee -a $LOG_FILE
exit 1
else
echo -e "$G You are with root access $N" | tee -a $LOG_FILE
fi


VALIDATE()
{
    if [ $1 -eq 0 ]
    then
    echo -e "$2 is $G successfully installed $N" | tee -a $LOG_FILE
    else
    echo -e "$R FAILURE: $2 is failed $N" | tee -a $LOG_FILE
    exit 1
    fi
}

for package in ${PACKAGES[@]}
do
    dnf list installed $package &>>$LOG_FILE
    if [ $? -ne 0 ]
    then
    echo "$package is going to install" | tee -a $LOG_FILE
    dnf install mysql -y
    VALIDATE $? "$package"
    else
    echo -e "$Y $package is already installed $N" | tee -a $LOG_FILE
    fi
done
