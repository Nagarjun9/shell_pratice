VALIDATION(){
    if [ $1 -ne 0 ]
    then 
        echo  "$2....failed"
        exit 1
    else 
        echo  "$2....success"
    fi 
}


dnf install nginx -y 
VALIDATION $? "installation of nginx"