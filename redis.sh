source common.sh

print_head "install redis repo"
dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>${LOG}
status_check

print_head "enable redis"
dnf module enable redis:remi-6.2 -y &>>${LOG}
status_check

print_head "install redis"
dnf install redis -y &>>${LOG}
status_check

print_head "update redis listening ip"
sed -i -e 's/127.0.0.1/0.0.0.0' /etc/redis.conf /etc/redis/redis.conf &>>${LOG}
status_check

systemctl enable redis
status_check
systemctl start redis
status_check
