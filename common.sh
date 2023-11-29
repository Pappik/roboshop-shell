script_location=$(pwd)
LOG=/tmp/roboshop.log
status_check() {
 if [ $? -eq 0 ]
 then
   echo -e "\e[1;32mSUCCESS\e[0m"
 else
   echo -e "\e[1;31mFAILURE\e[0m"
   echo "Refer LOG file for more information , LOG -${LOG}"
   exit 1
 fi
}


print_head(){
  echo -e "\e[35m$1\e[0m"
}

SYSTEMD () {
  print_head "copy ${component} service script"
  cp ${script_location}/files/${component}.service /etc/systemd/system/${component}.service &>>${LOG}
  status_check

  print_head "Daemon reload"
  systemctl daemon-reload &>>${LOG}
  status_check

  systemctl enable ${component}
  systemctl start ${component}
}

MONGODB () {
  cp ${script_location}/files/mongo.repo /etc/yum.repos.d/mongo.repo &>>${LOG}

  print_head "Mongodb client server"
  dnf install mongodb-org-shell -y &>>${LOG}
  status_check

  print_head "load schema"
  mongo --host 172.31.42.253 </app/schema/${component}.js &>>${LOG}
  status_check

}

APP_REQ () {

print_head "Useradd"
id roboshop &>>${LOG}
if [ $? -ne 0 ]
then
useradd roboshop
fi

print_head "create an application"
mkdir -p /app
status_check

print_head "Download and unzip  an application"
curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${LOG}
rm -rf /app/*
cd /app

unzip /tmp/${component}.zip &>>${LOG}
status_check

print_head "Download dependencies"
cd /app
npm install &>>${LOG}
status_check
}

NODEJS () {
  print_head "disable nodejs"
  dnf module disable nodejs -y &>>${LOG}
  status_check

  print_head "enable nodejs:18"
  dnf module enable nodejs:18 -y &>>${LOG}
  status_check

  print_head "Install nodejs"
  dnf install nodejs -y &>>${LOG}
  status_check
}