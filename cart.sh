source common.sh
component=cart

NODEJS

APP_REQ

print_head "Download dependencies"
cd /app
npm install &>>${LOG}
status_check

SYSTEMD
