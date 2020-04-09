#!/bin/bash

# This is a note of how to create vagrant box for odoo,
# not an install script that will run at once.
# Some of these commands below are interactive


sudo apt-get update
sudo apt-get upgrade -y

echo -e "\n--- Installing Python 3 + pip3 --"
sudo apt install -y --no-install-recommends  \
            python3-pip \
            python3-setuptools \
            python3-renderpm \
            libssl1.0-dev \
            xz-utils \
            python3-watchdog \
            python3-pypdf2 \
            python3-dev \
            gcc \
            wget \
            git \
            bzr gdebi-core zip unzip \
            libfontconfig1 libxrender1 libxext6 \
            fontconfig xfonts-75dpi xfonts-base \
            build-essential libldap2-dev libsasl2-dev ldap-utils libpq-dev libxml2-dev libxslt1-dev

echo -e "\n--- Installing pip3 packages"
sudo pip3 -r requirements.txt


#install wkhtml
echo -e "\n--- Install wkhtml"
WKHTMLTOX="https://builds.wkhtmltopdf.org/0.12.1.3/wkhtmltox_0.12.1.3-1~bionic_amd64.deb"
sudo wget $WKHTMLTOX
sudo gdebi --n `basename $WKHTMLTOX`
sudo ln -s /usr/local/bin/wkhtmltopdf /usr/bin
sudo ln -s /usr/local/bin/wkhtmltoimage /usr/bin
sudo rm `basename $WKHTMLTOX`

#switch to root and execute this before installing nodejs"

echo -e "\n---install nodejs"
sudo curl -sL https://deb.nodesource.com/setup_10.x | bash -
sudo apt install -y nodejs
sudo npm install -g less less-plugin-clean-css

#Install Postgres

echo -e "\n---create odoo user and postgres role"
sudo apt-get install postgresql -y
sudo -u postgres  psql -c "create role odoo with login password '123456';"
sudo adduser --system --quiet --shell=/bin/bash --home=$HOME --gecos 'ODOO' --group odoo



#Nginx
sudo apt install nginx -y
sudo cp -f odoo_nginx.conf /etc/nginx/sites-available/default
sudo service nginx restart
