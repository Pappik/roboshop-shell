source common.sh

component=shipping

print_head "install maven"
dnf install maven -y &>>${LOG}
status_check

APP_REQ

print_head "maven clean and run maven on shipping"
cd /app
mvn clean package &>>${LOG}
mv target/shipping-1.0.jar shipping.jar  &>>${LOG}
status_check

SYSTEMD

