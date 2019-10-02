#!/bin/bash

# This is a note of how to create vagrant box for odoo,
# not an install script that will run at once.
# Some of these commands below are interactive

WKHTMLTOX="https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.xenial_amd64.deb"

sudo apt-get update
sudo apt-get upgrade -y


echo -e "\n--- Installing Python 3 + pip3 --"
sudo apt-get install python3 python3-pip

echo -e "\n---- Install tool packages ----"
sudo apt-get install wget git bzr python-pip gdebi-core -y

echo -e "\n--- Install Postgres---"
sudo apt-get install libpq-dev postgres

echo -e "\n---- Install python packages ----"
sudo apt-get install python-pypdf2 python-dateutil python-feedparser python-ldap python-libxslt1 python-lxml python-mako python-openid python-psycopg2 python-pybabel python-pychart python-pydot python-pyparsing python-reportlab python-simplejson python-tz python-vatnumber python-vobject python-webdav python-werkzeug python-xlwt python-yaml python-zsi python-docutils python-psutil python-mock python-unittest2 python-jinja2 python-pypdf python-decorator python-requests python-passlib python-pil -y
sudo pip3 install pypdf2 Babel passlib Werkzeug decorator python-dateutil pyyaml psycopg2 psutil html2text docutils lxml pillow reportlab ninja2 requests gdata XlsxWriter vobject python-openid pyparsing pydot mock mako Jinja2 ebaysdk feedparser xlwt psycogreen suds-jurko pytz pyusb greenlet xlrd python-suds

echo -e "\n---- Install python libraries ----"
# This is for compatibility with Ubuntu 16.04. Will work on 14.04, 15.04 and 16.04
sudo apt-get install python3-suds

echo -e "\n--- Install other required packages"
sudo apt-get install node-clean-css node-gyp -y
sudo apt-get install node-less -y
sudo apt-get install python-gevent -y

#install wkhtml
echo -e "\n--- Install wkhtml"
sudo wget $WKHTMLTOX
sudo gdebi --n `basename $WKHTMLTOX`
sudo ln -s /usr/local/bin/wkhtmltopdf /usr/bin
sudo ln -s /usr/local/bin/wkhtmltoimage /usr/bin

echo -e "\n--- Install more for odoo12"

sudo apt-get install -y ca-certificates curl gnupg2 python3-setuptools python3-renderpm libssl-dev xz-utils python3-watchdog python3-pypdf2 python3-dev gcc pysassc python3-gevent

#switch to root and execute this before installing nodejs"
sudo curl -sL https://deb.nodesource.com/setup_10.x | bash -

echo -e "\n---install nodejs"
sudo apt-get install -y nodejs npm
sudo apt-get install -y npm
npm install -g less
npm install -g less-plugin-clean-css

sudo pip3 install --upgrade wheel
sudo pip3 install vobject wkhtmltopdf num2words phonenumbers pyOpenSSL newrelic num2words xlwt pypdf2 Babel passlib Werkzeug decorator python-dateutil pyyaml psycopg2 psutil html2text docutils lxml pillow reportlab ninja2 requests gdata XlsxWriter vobject python-openid pyparsing pydot mock mako Jinja2 ebaysdk feedparser xlwt psycogreen suds-jurko pytz pyusb greenlet xlrd libpq-dev

echo -e "\n---create odoo user and postgres role"
sudo apt-get install postgresql -y
sudo su - postgres -c "createuser -s odoo with encrypted password '123456'"
sudo adduser --system --quiet --shell=/bin/bash --home=$HOME --gecos 'ODOO' --group odoo
sudo adduser odoo sudo

####create systemd script if need be#########
sudo nano /lib/systemd/system/odoo.service
sudo systemctl enable odoo.service
sudo systemctl daemon-reload

