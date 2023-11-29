source common.sh

print_head "disable mysql"
dnf module disable mysql -y &>>${LOG}
status_check

print_head "copy mysql repo file"
cp ${script_location}/files/mysql.repo /etc/yum.repos.d/mysql.repo &>>${LOG}
status_check

print_head "Install Mysql"
dnf install mysql-community-server -y &>>${LOG}
status_check

systemctl enable mysqld
systemctl start mysqld

print_head "change default mysql password"
mysql_secure_installation --set-root-pass RoboShop@1 &>>${LOG}
status_check

