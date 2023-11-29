source common.sh

dnf module disable nodejs -y &>>{LOG}
status_check

dnf module enable nodejs:18 -y &>>{LOG}
status_check

dnf install nodejs -y &>>{LOG}
status_check

id roboshop
if [ $? -ne 0 ]
then
useradd roboshop
fi

mkdir -p /app
status_check

curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>{LOG}
cd /app
unzip /tmp/catalogue.zip &>>{LOG}

cd /app
npm install &>>{LOG}

cp ${script_location}/files/catalogue.service /etc/systemd/system/catalogue.service &>>{LOG}

systemctl daemon-reload &>>{LOG}

systemctl enable catalogue
systemctl start catalogue