dnf install nginx -y

rm -rf /usr/share/nginx/html/*

curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

cd /usr/share/nginx/html/
cp /tmp/frontend.zip

cp /files/roboshop.conf /usr/share/nginx/html/

systemctl enable nginx

systemctl restart nginx