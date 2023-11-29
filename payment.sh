source common.sh

component=payment

print_head "install python36"
dnf install python36 gcc python3-devel -y &>>${LOG}
status_check

APP_REQ

print_head "download dependencies"
cd /app
pip3.6 install -r requirements.txt &>>${LOG}
status_check

SYSTEMD


