script_location=$(pwd)

dnf install nginx -y
systemctl enable nginx

systemctl start nginx

rm -rf /usr/share/nginx/html/*

curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
unzip /tmp/frontend.zip

cp ${script_location}/files/roboshop.conf /etc/nginx/default.d/roboshop.conf

systemctl restart nginx