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
echo -n "Apa password mysql yg anda inginkan (huruf dan angka) :
"
read passmysql
echo "$passmysql" > deletepassmysql; clear
echo -n "Apa user database wordpress yg diinginkan :
"
read userdb
echo "$userdb" > deleteuserdb; clear
echo -n "Apa password database wordpress yg diinginkan :
"
read passdb
echo "$passdb" > deletepassdb; clear
echo -n "Apa user wordpress yg diinginkan :
"
read userwp
echo "$userwp" > deleteuserwp; clear
echo -n "Apa password wordpress yg diinginkan :
"
read passwp
echo "$passwp" > deletepasswp; clear
echo -n "Apa email wordpress yg diinginkan :
"
read emailwp
echo "$emailwp" > deleteemailwp; clear
#install x2go
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
apt-get install php5 php5-mysql php5-mcrypt php5-gd php5-fpm curl libcurl3 php5-curl
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
#install google-api-python-client dan progressbar2
pip install --upgrade google-api-python-client
pip install --upgrade google-api-python-client progressbar2
#install youtube upload
wget https://github.com/tokland/youtube-upload/archive/master.zip
unzip master.zip
cd youtube-upload-master
sudo python setup.py install
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
echo "$(cat deletevarnish)" > /etc/default/varnish2
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
wp core download --version=4.4.1 --allow-root
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
echo "wp theme install http://moviestreamfullhd.com/theme/$(printf "Rosas\nRoses\nRosis\nRosus\nRosos" | shuf -n 1).zip --activate --allow-root" | bash -
#delete theme unactive
wp theme delete $(wp theme list --status=inactive --field=name --allow-root) --allow-root
#install plugin
wp plugin install advanced-ads --activate --allow-root
wp plugin install adsense-privacy-policy --activate --allow-root
wp plugin install udinra-all-image-sitemap --allow-root
wp plugin install udinra-mobile-sitemap --allow-root
wp plugin install jetpack --activate --allow-root
wp plugin install wordpress-ping-optimizer --allow-root
wp plugin install forget-about-shortcode-buttons --activate --allow-root
wp plugin install akismet --activate --allow-root
wp plugin install wp-limit-login-attempts --activate --allow-root
wp plugin install google-sitemap-generator --allow-root
wp plugin install nginx-helper --allow-root
wp plugin install nginx-compatibility --allow-root
wp plugin install wp-seo-html-sitemap --activate --allow-root
wp plugin install http://moviestreamfullhd.com/plugin/all-in-one-seo-pack-pro-v2.3.7.2.zip --activate  --allow-root
wp plugin install http://moviestreamfullhd.com/plugin/no-ping-wait_2.zip --allow-root
wp plugin install http://moviestreamfullhd.com/plugin/searchterms-tagging-2.zip --allow-root
wp plugin install http://moviestreamfullhd.com/plugin/secure-folder-wp-content-uploads.zip  --allow-root
wp plugin install http://moviestreamfullhd.com/plugin/seo-booster-pro.zip  --allow-root
wp plugin install http://moviestreamfullhd.com/plugin/wp-freshstart.zip --activate  --allow-root
wp plugin install http://moviestreamfullhd.com/plugin/wp-all-import-pro.zip --activate  --allow-root
wp plugin install http://moviestreamfullhd.com/plugin/wp-rocket.zip  --allow-root
wp plugin install http://moviestreamfullhd.com/plugin/agc-spinner.zip  --allow-root
wp plugin install http://moviestreamfullhd.com/plugin/agk-mp3.zip  --allow-root
wp plugin install https://github.com/pkhamre/wp-varnish/archive/master.zip  --allow-root
chown -R www-data:www-data *
wp plugin update --all --allow-root
#buat page
wp post create --post_type=page --post_title='Sitemap'  --post_content='[wpseo_html_sitemap]' --post_status='publish' --allow-root
#langkahvps
echo "mkdir -p /home/www/$(cat /deletedomain)/image" | bash -
mkdir -p /home/ebay/artikel/data
mkdir -p /home/ebay/attachment/{data,done,spin,template,id}
mkdir -p /home/ebay/attachment/spin/{par1,par2,par3}
#artikel folder
wget https://github.com/nurd1n/Amazon-Ebay-Script/raw/Artikel/ask.py --no-check-certificate --directory-prefix=/home/ebay/artikel
wget https://github.com/nurd1n/Amazon-Ebay-Script/raw/Artikel/descriptionamazon.py --no-check-certificate --directory-prefix=/home/ebay/artikel
wget https://github.com/nurd1n/Amazon-Ebay-Script/raw/Artikel/detailamazon.py --no-check-certificate --directory-prefix=/home/ebay/artikel
wget https://github.com/nurd1n/Amazon-Ebay-Script/raw/Artikel/imageamazon.py --no-check-certificate --directory-prefix=/home/ebay/artikel
wget https://github.com/nurd1n/Amazon-Ebay-Script/raw/Artikel/reviewamazon.py --no-check-certificate --directory-prefix=/home/ebay/artikel
wget https://github.com/nurd1n/Amazon-Ebay-Script/raw/Artikel/titleamazon.py --no-check-certificate --directory-prefix=/home/ebay/artikel
wget https://github.com/nurd1n/Amazon-Ebay-Script/raw/Artikel/start1.sh --no-check-certificate --directory-prefix=/home/ebay/artikel
echo "curl -L https://github.com/nurd1n/Amazon-Ebay-Script/raw/Artikel/build.sh | sed -e 's/domain/$(cat /deletedomain)/g' -e 's/ekstension/$(cat /deleteekstension)/g'" | bash - > /home/ebay/artikel/build.sh
echo "curl -L https://github.com/nurd1n/Amazon-Ebay-Script/raw/Artikel/start2.sh | sed -e 's/domain/$(cat /deletedomain)/g' -e 's/ekstension/$(cat /deleteekstension)/g'" | bash - > /home/ebay/artikel/start2.sh
echo "curl -L https://github.com/nurd1n/Amazon-Ebay-Script/raw/Artikel/start3.sh | sed -e 's/domain/$(cat /deletedomain)/g' -e 's/ekstension/$(cat /deleteekstension)/g'" | bash - > /home/ebay/artikel/start3.sh
touch /home/ebay/artikel/data/asin.txt
touch /home/ebay/artikel/data/category.txt
#folder attachment
wget https://github.com/nurd1n/Amazon-Ebay-Script/raw/Attachment/a.sh --no-check-certificate --directory-prefix=/home/ebay/attachment
echo "curl -L https://github.com/nurd1n/Amazon-Ebay-Script/raw/Attachment/build.sh | sed -e 's/domain/$(cat /deletedomain)/g' -e 's/ekstension/$(cat /deleteekstension)/g'" | bash - > /home/ebay/attachment/build.sh
wget https://github.com/nurd1n/Amazon-Ebay-Script/raw/Attachment/start1.sh --no-check-certificate --directory-prefix=/home/ebay/attachment
echo "curl -L https://github.com/nurd1n/Amazon-Ebay-Script/raw/Attachment/start2.sh | sed -e 's/domain/$(cat /deletedomain)/g' -e 's/ekstension/$(cat /deleteekstension)/g'" | bash - > /home/ebay/attachment/start2.sh
echo "curl -L https://github.com/nurd1n/Amazon-Ebay-Script/raw/Attachment/sql1 | sed -e 's/domain/$(cat /deletedomain)/g' -e 's/ekstension/$(cat /deleteekstension)/g'" | bash - > /home/ebay/attachment/data/sql1
wget https://github.com/nurd1n/Amazon-Ebay-Script/raw/Attachment/sql2 --no-check-certificate --directory-prefix=/home/ebay/attachment/data
wget https://github.com/nurd1n/Amazon-Ebay-Script/raw/Attachment/sitemap --no-check-certificate --directory-prefix=/home/ebay/attachment/data
wget https://github.com/nurd1n/Amazon-Ebay-Script/raw/Attachment/tanggal --no-check-certificate --directory-prefix=/home/ebay/attachment/data
wget https://github.com/nurd1n/Amazon-Ebay-Script/raw/Attachment/ask.py --no-check-certificate --directory-prefix=/home/ebay/attachment
wget https://github.com/nurd1n/Amazon-Ebay-Script/raw/Attachment/descriptionamazon.py --no-check-certificate --directory-prefix=/home/ebay/attachment
wget https://github.com/nurd1n/Amazon-Ebay-Script/raw/Attachment/detailamazon.py --no-check-certificate --directory-prefix=/home/ebay/attachment
wget https://github.com/nurd1n/Amazon-Ebay-Script/raw/Attachment/imageamazon.py --no-check-certificate --directory-prefix=/home/ebay/attachment
wget https://github.com/nurd1n/Amazon-Ebay-Script/raw/Attachment/imageebay.py --no-check-certificate --directory-prefix=/home/ebay/attachment
wget https://github.com/nurd1n/Amazon-Ebay-Script/raw/Attachment/reviewamazon.py --no-check-certificate --directory-prefix=/home/ebay/attachment
wget https://github.com/nurd1n/Amazon-Ebay-Script/raw/Attachment/titleamazon.py --no-check-certificate --directory-prefix=/home/ebay/attachment
wget https://github.com/nurd1n/Amazon-Ebay-Script/raw/Attachment/titleebay.py --no-check-certificate --directory-prefix=/home/ebay/attachment
wget https://github.com/nurd1n/Amazon-Ebay-Script/raw/Attachment/urlebay.py --no-check-certificate --directory-prefix=/home/ebay/attachment
touch /home/ebay/attachment/data/asin.txt
#robots.txt
echo "curl -L https://github.com/nurd1n/ebay-Script/raw/artikel/robots.txt | sed -e 's/domain/$(cat /deletedomain)/g' -e 's/ekstension/$(cat /deleteekstension)/g' > /home/www/$(cat /deletedomain)/robots.txt" | bash -
chmod 755 /home/ebay/artikel/*.sh
chmod 755 /home/ebay/attachment/*.sh
# tambah user
echo "milley;$(wp user create milley milley@domain.com --role=author --display_name=Milley --user_pass=GhfrTDuy%67g^$*34 --porcelain --allow-root)" > /home/user.txt
echo "milley" > /home/ebay/artikel/data/author.txt
echo "martha;$(wp user create martha martha@domain.com --role=author --display_name=Martha --user_pass=GhfrTDuy%67g^$*35 --porcelain --allow-root)" >> /home/user.txt
echo "martha" >> /home/ebay/artikel/data/author.txt
echo "edward;$(wp user create edward edward@domain.com --role=author --display_name=Edward --user_pass=GhfrTDuy%67g^$*36 --porcelain --allow-root)" >> /home/user.txt
echo "edward" >> /home/ebay/artikel/data/author.txt
echo "samuel;$(wp user create samuel samuel@domain.com --role=author --display_name=Samuel --user_pass=GhfrTDuy%67g^$*37 --porcelain --allow-root)" >> /home/user.txt
echo "samuel" >> /home/ebay/artikel/data/author.txt
echo "daniel;$(wp user create daniel daniel@domain.com --role=author --display_name=Daniel --user_pass=GhfrTDuy%67g^$*38 --porcelain --allow-root)" >> /home/user.txt
echo "daniel" >> /home/ebay/artikel/data/author.txt
echo "cason;$(wp user create cason cason@domain.com --role=author --display_name=Cason --user_pass=GhfrTDuy%67g^$*39 --porcelain --allow-root)" >> /home/user.txt
echo "cason" >> /home/ebay/artikel/data/author.txt
echo "vandiver;$(wp user create vandiver vandiver@domain.com --role=author --display_name=Vandiver --user_pass=GhfrTDuy%67g^$*40 --porcelain --allow-root)" >> /home/user.txt
echo "vandiver" >> /home/ebay/artikel/data/author.txt
echo "teresa;$(wp user create teresa teresa@domain.com --role=author --display_name=Teresa --user_pass=GhfrTDuy%67g^$*41 --porcelain --allow-root)" >> /home/user.txt
echo "teresa" >> /home/ebay/artikel/data/author.txt
echo "collins;$(wp user create collins collins@domain.com --role=author --display_name=Collins --user_pass=GhfrTDuy%67g^$*42 --porcelain --allow-root)" >> /home/user.txt
echo "collins" >> /home/ebay/artikel/data/author.txt
echo "carole;$(wp user create carole carole@domain.com --role=author --display_name=Carole --user_pass=GhfrTDuy%67g^$*43 --porcelain --allow-root)" >> /home/user.txt
echo "carole" >> /home/ebay/artikel/data/author.txt
echo "tomlin;$(wp user create tomlin tomlin@domain.com --role=author --display_name=Tomlin --user_pass=GhfrTDuy%67g^$*44 --porcelain --allow-root)" >> /home/user.txt
echo "tomlin" >> /home/ebay/artikel/data/author.txt
echo "sharoon;$(wp user create sharoon sharoon@domain.com --role=author --display_name=Sharoon --user_pass=GhfrTDuy%67g^$*45 --porcelain --allow-root)" >> /home/user.txt
echo "sharoon" >> /home/ebay/artikel/data/author.txt
echo "issac;$(wp user create issac issac@domain.com --role=author --display_name=Issac --user_pass=GhfrTDuy%67g^$*46 --porcelain --allow-root)" >> /home/user.txt
echo "issac" >> /home/ebay/artikel/data/author.txt
echo "samantha;$(wp user create samantha samantha@domain.com --role=author --display_name=Samantha --user_pass=GhfrTDuy%67g^$*47 --porcelain --allow-root)" >> /home/user.txt
echo "samantha" >> /home/ebay/artikel/data/author.txt
echo "turner;$(wp user create turner turner@domain.com --role=author --display_name=Turner --user_pass=GhfrTDuy%67g^$*48 --porcelain --allow-root)" >> /home/user.txt
echo "turner" >> /home/ebay/artikel/data/author.txt
cp /home/ebay/artikel/data/author.txt /home/ebay/attachment/data/author.txt
chown -R www-data:www-data *
echo "chmod 777 /home/www/$(cat /deletedomain)" | bash -
#download file yg dibutuhkan
curl -L https://github.com/nurd1n/LEMP-Wordpress/raw/secret/aiopluginsetting.ini -o /home/aiopluginsetting.ini
curl -L https://github.com/nurd1n/LEMP-Wordpress/raw/secret/wpallimport.txt -o /home/wpallimport.txt
curl -L https://github.com/nurd1n/LEMP-Wordpress/raw/secret/wordpressping.txt -o /home/wordpressping.txt
curl -L http://moviestreamfullhd.com/plugin/license-agc-spinner.txt -o /home/license-agc-spinner.txt
