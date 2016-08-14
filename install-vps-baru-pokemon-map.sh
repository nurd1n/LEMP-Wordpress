cd /
clear && clear
apt-get update
sudo apt-get install apt-transport-https gawk python-setuptools software-properties-common python-dev
apt-get -y install aptitude
#install pip
cd /tmp
wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py
pip install -U pip
#install git
apt-get install git-all
#install nodejs & npm
curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
sudo apt-get install -y nodejs
#install pokemon go map
cd /home
git clone https://github.com/PokemonGoMap/PokemonGo-Map.git
cd PokemonGo-Map
pip install -r requirements.txt
pip install -r requirements.txt --upgrade
pip install git+https://github.com/ChrisTM/Flask-CacheBust.git@master#egg=flask_cachebust --upgrade
pip install -e git+https://github.com/keyphact/pgoapi.git@a2755eb42dfe49e359798d2f4defefc97fb8163d#egg=pgoapi --upgrade
pip install six --upgrade
pip install -r requirements.txt --upgrade
git submodule init
git submodule update
git pull
npm install
npm run build
#install x2go
cd /
echo "deb http://packages.x2go.org/debian squeeze main" >> /etc/apt/sources.list
echo "deb-src http://packages.x2go.org/debian squeeze main" >> /etc/apt/sources.list
curl https://repo.varnish-cache.org/ubuntu/GPG-key.txt | apt-key add - 
echo "deb https://repo.varnish-cache.org/ubuntu/ trusty varnish-4.0" >> /etc/apt/sources.list.d/varnish-cache.list
apt-key adv --recv-keys --keyserver keys.gnupg.net E1F958385BFE2B6E
apt-get update
apt-get upgrade
apt-get dist-upgrade
aptitude update && aptitude install x2go-keyring
aptitude install x2goserver
apt-get install xorg lxde-core
#install nginx
sudo -s
nginx=stable
add-apt-repository ppa:nginx/$nginx
apt-get update
apt-get install nginx-extras
#install php5-fpm
apt-get update
apt-get install php5
apt-get install php5-mysql
apt-get install php5-mysqlnd
apt-get install php5-mcrypt
apt-get install php5-gd
apt-get install php5-fpm
apt-get install php5-curl
apt-get install curl libcurl3
#install mariadb
sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
sudo add-apt-repository 'deb http://mirrors.coreix.net/mariadb/repo/10.0/ubuntu vivid main'
sudo apt-get update
sudo apt-get install mariadb-server mariadb-client
service mysql restart
mysql_secure_installation
#install yg diperlukan
sudo apt-get install at midori bleachbit gedit terminator filezilla unzip
sudo service nginx restart; sudo service php5-fpm restart
clear
cd /
# edit default host
sed -i 's|index\.html|index\.php index\.html|g' /etc/nginx/sites-enabled/default
echo "sed -i '49 a     location /phpmyadmin { alias   /var/www/html/phpmyadmin/; index  index.php index.html index.htm;}' /etc/nginx/sites-enabled/default" | bash -
echo "sed -i '50 a     location ~ \.php$ {include snippets/fastcgi-php.conf; fastcgi_pass unix:/var/run/php5-fpm.sock;}' /etc/nginx/sites-enabled/default" | bash -
sudo service nginx restart; sudo service php5-fpm restart; service mysql restart; service varnish restart
# download phpmyadmin
cd /var/www/html
mkdir -p phpmyadmin
cd phpmyadmin
sudo wget https://files.phpmyadmin.net/phpMyAdmin/4.6.3/phpMyAdmin-4.6.3-all-languages.tar.gz
tar -zxvf phpMyAdmin-4.6.3-all-languages.tar.gz
sudo mv phpMyAdmin-4.6.3*/* .
sudo rm phpMyAdmin-4.6.3-all-languages.tar.gz
sudo chown -R www-data:www-data /var/www/html/phpmyadmin
cd /
sudo service nginx restart; sudo service php5-fpm restart
clear
