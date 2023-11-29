dnf module diable nodejs -y
dnf module enable nodejs:18 -y

dnf install nodejs -y

id roboshop
if [ $? != 0 ]
then
useradd roboshop
fi

mkdir /app