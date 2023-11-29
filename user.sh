source common.sh
component=user

NODEJS

APP_REQ

print_head "Download dependencies"
cd /app
npm install &>>${LOG}
status_check

SYSTEMD

MONGODB