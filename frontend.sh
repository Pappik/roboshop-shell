source common.sh

print_head "install ni=ginx"
dnf install nginx -y &>>${LOG}
status_check

systemctl enable nginx

systemctl start nginx

print_head "remove old content"
rm -rf /usr/share/nginx/html/* &>>${LOG}
status_check


print_head "copy nginx files to location"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${LOG}
status_check

cd /usr/share/nginx/html/

print_head "unzip nginx files"
unzip /tmp/frontend.zip &>>${LOG}
status_check


cp ${script_location}/files/roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${LOG}
status_check


systemctl restart nginx