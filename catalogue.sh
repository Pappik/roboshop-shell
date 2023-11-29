source common.sh

dnf module disable nodejs -y
dnf module enable nodejs:18 -y

dnf install nodejs -y

id roboshop
if [ $? -ne 0 ]
then
useradd roboshop
fi

mkdir -p /app

curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app
unzip /tmp/catalogue.zip

cd /app
npm install

cp ${script_location}/files/catalogue.service /etc/systemd/system/catalogue.service

systemctl daemon-reload

systemctl enable catalogue
systemctl start catalogue