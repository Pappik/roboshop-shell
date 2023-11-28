dnf install nginx -y

rm -rf /usr/share/nginx/html/*

curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

cp /tmp/frontend.zip /usr/share/nginx/html/
unzip frontend.zip

cp /files/roboshop.conf /usr/share/nginx/html/

systemctl enable nginx

systemctl restart nginx