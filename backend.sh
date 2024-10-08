#!/bin/bash 

USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log 
R="\e[31m" 
G="\e[32m" 
Y="\e[33m"
N="\e[0m" 
echo "Please enter DB password:"
read -s mysql_root_password

VALIDATE(){
    if [ $1 -ne 0 ]
    then 
        echo -e "$2...$R FAILURE $N" 
        exit 1
    else 
        echo -e "$2...$R SUCCESS $N" 
    fi 
}

if [ $USERID -ne 0 ]
then 
    echo "please run this script with root access" 
    exit 1 
else 
    echo "You are super user." 
fi 

dnf module disable nodejs -y &>>$LOGFILE 
VALIDATE $? "Disabling nodejs:20 version" 

dnf module enable nodejs:20 -y &>>$LOGFILE 
VALIDATE $? "Enabling nodejs:20 version" 

dnf install nodejs -y &>>$LOGFILE 
VALIDATE $? "Installing nodejs" 

id expense &>>$LOGFILE 
if [ $? -ne 0 ]
then 
    useradd expense &>>$LOGFILE 
    VALIDATE $? "Creating expense user" 
else 
    echo -e "Expense user already created...$Y SKIPPING $N"
fi 

mkdir -p /app &>>$LOGFILE
VALIDATE $? "directory created"
curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip &>>$LOGFILE
VALIDATE $? "downloaded backendcode"

cd /app
rm -rf *
unzip /tmp/backend.zip &>>$LOGFILE
VALIDATE $? "unzip the code in app folder"

npm install &>>$LOGFILE 
VALIDATE $? "Installing nodejs dependencies" 

#check your repo and path
cp /home/ec2-user/shell_pratice/backend.service /etc/systemd/system/backend.service &>>$LOGFILE
VALIDATE $? "Copied backend service" 

systemctl daemon-reload &>>$LOGFILE 
VALIDATE $? "Daemon Reload" 

systemctl start backend &>>$LOGFILE 
VALIDATE $? "starting backend" 

systemctl enable backend &>>$LOGFILE 
VALIDATE $? "Enabling backend" 

dnf install mysql -y &>>$LOGFILE 
VALIDATE $? "Installing MySQL Client" 

mysql -h 172.31.56.198 -uroot -p${mysql_root_password} < /app/schema/backend.sql &>>$LOGFILE
VALIDATE $? "Schema loading" 

systemctl restart backend &>>$LOGFILE 
VALIDATE $? "Restarting Backend" 

