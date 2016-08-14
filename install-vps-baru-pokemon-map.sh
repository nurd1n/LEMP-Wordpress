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
pip install six --upgrade
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
curl -L https://github.com/nurd1n/LEMP-Wordpress/raw/secret/nginx.conf -o deletenginx.conf
echo "$(cat deletenginx.conf)" > /etc/nginx/nginx.conf
curl -L https://github.com/nurd1n/LEMP-Wordpress/raw/secret/mime.types -o deletemime.types
echo "$(cat deletemime.types)" > /etc/nginx/mime.types
curl -L https://github.com/nurd1n/LEMP-Wordpress/raw/secret/php.ini -o deletephp.ini
echo "$(cat deletephp.ini)" >> /etc/php5/fpm/php.ini
sed -i 's/cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php5/fpm/php.ini
sed -i 's/allow_url_fopen = Off/allow_url_fopen = On/g' /etc/php5/fpm/php.ini
sed -i 's/allow_url_include = Off/allow_url_include = On/g' /etc/php5/fpm/php.ini
sed -i 's/post_max_size = 8M/post_max_size = 35M/g' /etc/php5/fpm/php.ini
sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 20M/g' /etc/php5/fpm/php.ini
sed -i 's/max_execution_time = 30/max_execution_time = 600/g' /etc/php5/fpm/php.ini
sed -i 's/;ignore_user_abort = On/ignore_user_abort = Off/g' /etc/php5/fpm/php.ini
sed -i 's/default_socket_timeout = 60/default_socket_timeout = 30/g' /etc/php5/fpm/php.ini
sed -i 's/mysql.allow_persistent = On/mysql.allow_persistent = Off/g' /etc/php5/fpm/php.ini
sed -i 's|pid = /run/php5-fpm.pid|pid = /var/run/php5-fpm.pid|g' /etc/php5/fpm/php-fpm.conf
sed -i 's|;emergency_restart_threshold = 0|emergency_restart_threshold = 5|g' /etc/php5/fpm/php-fpm.conf
sed -i 's|;emergency_restart_interval = 0|emergency_restart_interval = 2|g' /etc/php5/fpm/php-fpm.conf
sed -i 's|;events.mechanism = epoll|events.mechanism = epoll|g' /etc/php5/fpm/php-fpm.conf
sed -i 's|;listen.mode = 0660|listen.mode = 0666|g' /etc/php5/fpm/pool.d/www.conf
sed -i 's|;listen.allowed_clients = 127.0.0.1|listen.allowed_clients = 127.0.0.1|g' /etc/php5/fpm/pool.d/www.conf
sed -i 's|pm.max_children = 5|pm.max_children = 50|g' /etc/php5/fpm/pool.d/www.conf
sed -i 's|pm.start_servers = 2|pm.start_servers = 15|g' /etc/php5/fpm/pool.d/www.conf
sed -i 's|pm.min_spare_servers = 1|pm.min_spare_servers = 5|g' /etc/php5/fpm/pool.d/www.conf
sed -i 's|pm.max_spare_servers = 3|pm.max_spare_servers = 25|g' /etc/php5/fpm/pool.d/www.conf
sed -i 's|;pm.process_idle_timeout = 10s;|pm.process_idle_timeout = 60s|g' /etc/php5/fpm/pool.d/www.conf
sed -i 's|;request_terminate_timeout = 0|request_terminate_timeout = 30|g' /etc/php5/fpm/pool.d/www.conf
sed -i 's|;security.limit_extensions = .php .php3 .php4 .php5|security.limit_extensions = .php|g' /etc/php5/fpm/pool.d/www.conf
sed -i 's|;php_flag[display_errors] = off|php_flag[display_errors] = off|g' /etc/php5/fpm/pool.d/www.conf
sed -i 's|;php_admin_value[error_log] = /var/log/fpm-php.www.log|php_admin_value[error_log] = /var/log/php5-fpm.log|g' /etc/php5/fpm/pool.d/www.conf
sed -i 's|;php_admin_flag[log_errors] = on|php_admin_flag[log_errors] = on|g' /etc/php5/fpm/pool.d/www.conf
sed -i 's|;php_admin_value[memory_limit] = 32M|php_admin_value[memory_limit] = 128M|g' /etc/php5/fpm/pool.d/www.conf
echo "php_admin_value[error_reporting] = 0" >> /etc/php5/fpm/pool.d/www.conf
curl -L https://github.com/nurd1n/LEMP-Wordpress/raw/secret/varnish -o deletevarnish
echo "$(cat deletevarnish)" > /etc/default/varnish
curl -L https://github.com/nurd1n/LEMP-Wordpress/raw/secret/default.vcl -o deletedefault.vcl
echo "$(cat deletedefault.vcl)" > /etc/varnish/default.vcl
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
