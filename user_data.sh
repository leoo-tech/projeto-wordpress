#!/bin/bash

exec > /var/log/user-data.log 2>&1
set -euxo pipefail

dnf update -y
dnf install -y docker
systemctl enable --now docker
usermod -aG docker ec2-user

mkdir -p /usr/libexec/docker/cli-plugins
curl -SL "https://github.com/docker/compose/releases/download/v2.23.0/docker-compose-linux-x86_64" -o /usr/libexec/docker/cli-plugins/docker-compose
chmod +x /usr/libexec/docker/cli-plugins/docker-compose

mkdir -p /mnt/efs
sudo mount -t nfs4 -o nfsvers=4.1 <EFS_ENDPOINT>:/ /mnt/efs

while ! mountpoint -q /mnt/efs; do
  sleep 2
done

mkdir -p /mnt/efs/wordpress
sudo chown -R 33:33 /mnt/efs/wordpress

sudo -u ec2-user bash -c 'cat > /home/ec2-user/docker-compose.yaml <<EOF
version: "3.8"
services:
  wordpress:
    image: wordpress
    restart: always
    ports:
      - "80:80"
    environment:
      WORDPRESS_DB_HOST: <your_db_host>
      WORDPRESS_DB_USER: <your_db_user>
      WORDPRESS_DB_PASSWORD: <your_db_password>
      WORDPRESS_DB_NAME: <your_db_name>
    volumes:
      - /mnt/efs/wordpress:/var/www/html
EOF'

sudo -u ec2-user bash -c "cd /home/ec2-user && docker compose up -d"
	