cd /
clear && clear
echo -n "Apa nama domain anda (tanpa dot com) :
"
read domain
echo "$domain" > deletedomain; clear
echo -n "Apa nama ekstension domain anda (com, net, org, xyz, dll) :
"
read ekstension
echo "$ekstension" > deleteekstension; clear
echo "http://www.$(cat /deletedomain).$(cat /deleteekstension)" >> /home/database.txt
echo -n "Apa password mysql yg anda inginkan (huruf dan angka) :
"
read passmysql
echo "$passmysql" > deletepassmysql; clear
echo -n "Apa inisial blog anda (huruf kecil semua) :
"
read inisial
echo "$inisial" > deleteinisial; clear
echo -n "Apa keyword blog anda (huruf kecil semua) :
"
read keyword
echo "$keyword" > deletekeyword; clear
tr -cd '[:alnum:]' < /dev/urandom | fold -w20 | head -n1 > deleteuserdb; clear
tr -cd '[:alnum:]' < /dev/urandom | fold -w20 | head -n1 > deletepassdb; clear
echo "user db wp : $(cat /deleteuserdb)" >> /home/database.txt
echo "pass db wp : $(cat /deletepassdb)" >> /home/database.txt
echo "leeedwardjoon" > deleteuserwp; clear
echo "leeedwardjoon" > deletepasswp; clear
echo "leeedwardjoon@gmail.com" > deleteemailwp; clear
#install x2go
sudo apt-get install apt-transport-https
apt-get update && apt-get -y install aptitude
apt-get install gawk python-setuptools software-properties-common
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
sudo apt-get install at sendmail ffmpeg midori bleachbit gedit terminator filezilla libimage-exiftool-perl unzip python-pip varnish
#install mechanize & beautifulsoup
easy_install mechanize
easy_install BeautifulSoup4
cd /
curl -L https://github.com/nurd1n/LEMP-Wordpress/raw/secret/nginx.conf -o deletenginx.conf
echo "$(cat deletenginx.conf)" > /etc/nginx/nginx.conf
curl -L https://github.com/nurd1n/LEMP-Wordpress/raw/secret/mime.types -o deletemime.types
echo "$(cat deletemime.types)" > /etc/nginx/mime.types
curl -L https://github.com/nurd1n/LEMP-Wordpress/raw/secret/php.ini -o deletephp.ini
echo "$(cat deletephp.ini)" >> /etc/php5/fpm/php.ini
sed -i 's/cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php5/fpm/php.ini
sed -i 's/allow_url_fopen = Off/allow_url_fopen = On' /etc/php5/fpm/php.ini
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
curl -L https://github.com/nurd1n/LEMP-Wordpress/raw/secret/block -o deleteblock
#get ip adress
ifconfig venet0:0 | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}' > deleteipadress
echo "cat deleteblock | sed -e 's/domain/$(cat deletedomain)/g' -e 's/ekstension/$(cat deleteekstension)/g' -e 's/ipadress/$(cat deleteipadress)/g' > /etc/nginx/sites-available/$(cat deletedomain).$(cat deleteekstension)" | bash -
echo "sudo ln -s /etc/nginx/sites-available/$(cat deletedomain).$(cat deleteekstension) /etc/nginx/sites-enabled/$(cat deletedomain).$(cat deleteekstension)" | bash -
echo "mkdir -p /home/www/$(cat deletedomain)" | bash -
sudo service nginx restart; sudo service php5-fpm restart; service mysql restart; service varnish restart
# install wp-cli
cd /tmp
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp
wp --info --allow-root
# Install Wordpress and Configure the Database
eval $(echo "cd /home/www/$(cat /deletedomain)")
# Install wordpress terbaru
wp core download --version=4.5 --allow-root
chown -R www-data:www-data *
# Create database, ganti password, wordpressdb
echo "echo \"echo \\\"create database wp_\$(cat /deletedomain); create user \$(cat /deleteuserdb)@localhost identified by '\$(cat /deletepassdb)'; grant all privileges on wp_\$(cat /deletedomain).* to \$(cat /deleteuserdb)@localhost identified by '\$(cat /deletepassdb)'; flush privileges\\\" | mysql -u root \\\"-p\$(cat /deletepassmysql)\\\"\"" | bash - | bash -
echo "wp core config --dbname=wp_$(cat /deletedomain) --dbuser=$(cat /deleteuserdb) --dbpass=$(cat /deletepassdb) --allow-root" | bash -
echo "wp core install --url=www.$(cat /deletedomain).$(cat /deleteekstension) --title=$(cat /deletedomain) --admin_user=$(cat /deleteuserwp) --admin_password=$(cat /deletepasswp) --admin_email=$(cat /deleteemailwp) --allow-root" | bash -
#delete all spam comments.
wp comment delete $(wp comment list --status=spam --allow-root) --force --allow-root
#delete all approved comments.
wp comment delete $(wp comment list --status=approve --allow-root) --force --allow-root
#delete all trash comments.
wp comment delete $(wp comment list --status=trash --allow-root) --allow-root
#Hapus page tanpa trash dulu
wp post delete $(wp post list --post_type='page' --allow-root) --force --allow-root
#Hapus post tanpa trash dulu
wp post delete $(wp post list --post_type='post' --allow-root) --force --allow-root
#Hapus attachment tanpa trash dulu
wp post delete $(wp post list --post_type='attachment' --allow-root) --force --allow-root
#Hapus trash
wp post delete $(wp post list --post_status=trash --allow-root) --force --allow-root
#delete widget
wp widget delete $(wp widget list sidebar-1 --format=ids --allow-root) --allow-root
#Delete inactive plugins
wp plugin delete $(wp plugin list --status=inactive --field=name --allow-root) --allow-root
#install & activate theme
printf "Rosas\nRoses\nRosis\nRosus\nRosos" | shuf -n 1 > /deletetheme
echo "wp theme install http://moviestreamfullhd.com/theme/$(cat /deletetheme).zip --activate --allow-root" | bash -
echo "wp theme activate $(cat /deletetheme) --allow-root" | bash -
#delete theme unactive
wp theme delete $(wp theme list --status=inactive --field=name --allow-root) --allow-root
#install plugin
wp plugin install advanced-ads --activate --allow-root
wp plugin install adsense-privacy-policy --activate --allow-root
wp plugin install udinra-all-image-sitemap --activate --allow-root
wp plugin install wordpress-ping-optimizer --activate --allow-root
wp plugin install forget-about-shortcode-buttons --activate --allow-root
wp plugin install akismet --activate --allow-root
wp plugin install wp-limit-login-attempts --activate --allow-root
wp plugin install google-sitemap-generator --activate --allow-root
wp plugin install nginx-helper --activate --allow-root
wp plugin install nginx-compatibility --activate --allow-root
wp plugin install wp-seo-html-sitemap --activate --allow-root
wp plugin install http://moviestreamfullhd.com/plugin/all-in-one-seo-pack-pro-v2.3.7.2.zip --activate  --allow-root
wp plugin install http://moviestreamfullhd.com/plugin/no-ping-wait_2.zip --activate --allow-root
wp plugin install http://moviestreamfullhd.com/plugin/wp-freshstart.zip --activate  --allow-root
wp plugin install http://moviestreamfullhd.com/plugin/wp-all-import-pro.zip --activate  --allow-root
wp plugin install https://github.com/pkhamre/wp-varnish/archive/master.zip --activate  --allow-root
chown -R www-data:www-data *
wp plugin update --all --allow-root
echo "curl -L https://github.com/nurd1n/LEMP-Wordpress/raw/secret/extra | sed -e 's/domain1/$(cat /deletedomain)/g' -e 's/ekstension1/$(cat /deleteekstension)/g' > extra.sh" | bash -
chmod 755 extra.sh
./extra.sh
rm -f extra.sh
echo "curl -L http://moviestreamfullhd.com/wpdatabase/domain.sql | sed -e 's|lailykitchen.xyz|$(cat /deletedomain).$(cat /deleteekstension)|g' -e 's|lailykitchen|$(cat /deletedomain)|g' -e 's|kitchen1|$(cat /deletekeyword)|g' -e 's|Laily|$(cat /deleteinisial | sed -e 's/+/ /g' -e 's/.*/\L&/; s/[a-z]*/\u&/g')|g' -e 's|Kitchen|$(cat /deletekeyword | sed -e 's/+/ /g' -e 's/.*/\L&/; s/[a-z]*/\u&/g')|g' -e 's|laily|$(cat /deleteinisial)|g' -e 's|kitchen|$(cat /deletekeyword)|g' -e 's|f0d7c9d7-d72b-46c2-8ab6-b74165057961|$(cat /etc/varnish/secret)|g' > wp_$(cat /deletedomain).sql" | bash -
echo "mysql -u $(cat /deleteuserdb) \"-p$(cat /deletepassdb)\" wp_$(cat /deletedomain) < wp_$(cat /deletedomain).sql" | bash -
echo "rm -f wp_$(cat /deletedomain).sql" | bash -
cd wp-content/uploads
curl -L http://moviestreamfullhd.com/wpdatabase/uploads.tar.gz -o uploads.tar.gz
tar -zxvf uploads.tar.gz
rm -f uploads.tar.gz
eval $(echo "cd /home/www/$(cat /deletedomain)")
chown -R www-data:www-data *
wp plugin update --all --allow-root
echo "wp theme install http://moviestreamfullhd.com/theme/$(cat /deletetheme).zip --activate --allow-root" | bash -
echo "wp theme activate $(cat /deletetheme) --allow-root" | bash
wp core update-db --allow-root
wp plugin delete no-ping-wait wordpress-ping-optimizer wp-limit-login-attempts --allow-root
