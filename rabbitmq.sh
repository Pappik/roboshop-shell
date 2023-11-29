source common.sh

print_head "configure yum repos"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>>${LOG}
status_check

print_head "rabbitmq yum repos"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>>${LOG}
status_check

print_head "INstall Rabbitmq"
dnf install rabbitmq-server -y &>>${LOG}
status_check

systemctl enable rabbitmq-server
systemctl start rabbitmq-server

print_head "add rabbitmq user and pass"
rabbitmqctl add_user roboshop roboshop123
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
status_check