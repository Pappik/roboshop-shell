source common.sh

print_head "disable nodejs"
dnf module disable nodejs -y &>>{LOG}
status_check

print_head "enable nodejs"
dnf module enable nodejs:18 -y &>>{LOG}
status_check

print_head "Install nodejs"
dnf install nodejs -y &>>{LOG}
status_check

print_head "Useradd"
id roboshop
if [ $? -ne 0 ]
then
useradd roboshop
fi

print_head "create an application"
mkdir -p /app
status_check

print_head "Download and unzip  an application"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>{LOG}
cd /app
unzip /tmp/catalogue.zip &>>{LOG}
status_check

print_head "Download dependencies"
cd /app
npm install &>>{LOG}
status_check

print_head "copy service script"
cp ${script_location}/files/catalogue.service /etc/systemd/system/catalogue.service &>>{LOG}
status_check

print_head "Daemon reload"
systemctl daemon-reload &>>{LOG}
status_check

systemctl enable catalogue
systemctl start catalogue