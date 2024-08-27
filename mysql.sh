#!/bin/bash

USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log 
R="\e[31m"
G="\e[32m"
Y="\e[33"
N="\e[0m"
echo "Please enter DB password:"
read -s mysql_root_password 

# VALIDATE(){
#     if [ $1 -ne 0 ]
#     then 
#         echo -e "$2...$R FAILURE $N"
#         exit 1 
#     else 
#         echo -e "$2...$G SUCCESS $N"
# }

VALIDATE(){
   if [ $1 -ne 0 ]
   then
        echo -e "$2...$R FAILURE $N"
        exit 1
    else
        echo -e "$2...$G SUCCESS $N"
    fi
}

if [ $USERID -ne 0 ]
then 
    echo "Please run this script with root access."
    exit 1
else 
    echo "you are super user"
if 

dnf install mysql-serer -y &>>$LOGFILE 
VALIDATE $? "installing MySQL server" 

systemctl enable mysqlid &>>$LOGFILE 
VALIDATE $? "Enableing MySQL server" 

systemctl start mysqlid &>>$LOGFILE 
VALIDATE $? "starting MySQL Server" 

mysql_secure_installation --set-root-pass ${mysql_root_password} &>>$LOGFILE
VALIDATION $? "setup the root password"