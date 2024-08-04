dnf module disable nodejs -y
dnf module enable nodejs:20 -y
dnf install nodejs -y

useradd expense
mkdir /app

curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip

cd /app
unzip /tmp/backend.zip
npm install

vim /etc/systemd/system/backend.service

systemctl daemon-reload
systemctl start backend
systemctl enable backend

dnf install mysql -y
mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -pExpenseApp1 < /app/schema/backend.sql
systemctl restart backend