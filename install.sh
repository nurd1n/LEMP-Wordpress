cd /
clear
echo -n "Apa nama domain anda (tanpa dot com) :
"
read domain
echo "$domain" > deletedomain; clear
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
apt-get install gawk
apt-get install python-setuptools
echo "deb http://packages.x2go.org/debian squeeze main" >> /etc/apt/sources.list
echo "deb-src http://packages.x2go.org/debian squeeze main" >> /etc/apt/sources.list
apt-key adv --recv-keys --keyserver keys.gnupg.net E1F958385BFE2B6E
apt-get update
apt-get upgrade
apt-get dist-upgrade
aptitude update && aptitude install x2go-keyring
aptitude install x2goserver
apt-get install xorg lxde-core
#install mechanize & beautifulsoup
easy_install mechanize
easy_install BeautifulSoup4
#install mariadb
sudo apt-get install software-properties-common
sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
sudo add-apt-repository 'deb http://mirrors.coreix.net/mariadb/repo/10.0/ubuntu vivid main'
sudo apt-get update
sudo apt-get install mariadb-server
mysql_secure_installation
sudo apt-get install nginx mariadb-client php5 php5-fpm php5-mysql php5-gd curl libcurl3 php5-curl at sendmail ffmpeg midori bleachbit gedit terminator filezilla libimage-exiftool-perl
sed -i 's/cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php5/fpm/php.ini
sed -i 's/post_max_size = 8M/post_max_size = 35M/g' /etc/php5/fpm/php.ini
sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 20M/g' /etc/php5/fpm/php.ini
sed -i 's/max_execution_time = 30/max_execution_time = 600/g' /etc/php5/fpm/php.ini
wget https://github.com/nurd1n/LEMP-Wordpress/raw/secret/block --no-check-certificate
echo "cat block | sed 's/domain/$(cat deletedomain)/g' > /etc/nginx/sites-available/$(cat deletedomain)" | bash -
echo "sudo ln -s /etc/nginx/sites-available/$(cat deletedomain) /etc/nginx/sites-enabled/$(cat deletedomain)" | bash -
echo "mkdir -p /home/$(cat deletedomain)/wordpress" | bash -
sudo service nginx restart; sudo service php5-fpm restart; service mysql restart
# install wp-cli
cd /tmp
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp
wp --info --allow-root
# Install Wordpress and Configure the Database
echo "cd /home/$(cat /deletedomain)/wordpress/" | bash -
# Install wordpress terbaru
wp core download --version=4.4.1 --allow-root
chown -R www-data:www-data *
# Create database, ganti password, wordpressdb
echo "echo \"echo \\\"create database wp_\$(cat /deletedomain); create user \$(cat /deleteuserdb)@localhost identified by '\$(cat /deletepassdb)'; grant all privileges on wp_\$(cat /deletedomain).* to \$(cat /deleteuserdb)@localhost identified by '\$(cat /deletepassdb)'; flush privileges\\\" | mysql -u root \\\"-p\$(cat /deletepassmysql)\\\"\"" | bash - | bash -
echo "wp core config --dbname=wp_$(cat /deletedomain) --dbuser=$(cat /deleteuserdb) --dbpass=$(cat /deletepassdb) --allow-root" | bash -
echo "define( 'UPLOADS', ''.'image' );" >> wp-config.php
echo "wp core install --url=www.$(cat /deletedomain).com --title=$(cat /deletedomain) --admin_user=$(cat /deleteuserwp) --admin_password=$(cat /deletepasswp) --admin_email=$(cat /deleteemailwp) --allow-root" | bash -
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
wp theme install http://moviestreamfullhd.com/theme/Adsos.zip --allow-root
wp theme activate Adsos --allow-root
#delete theme unactive
wp theme delete $(wp theme list --status=inactive --field=name --allow-root) --allow-root
#install plugin
wp plugin install advanced-ads --activate --allow-root
wp plugin install adsense-privacy-policy --activate --allow-root
wp plugin install udinra-all-image-sitemap --activate --allow-root
wp plugin install udinra-mobile-sitemap --activate --allow-root
wp plugin install bwp-google-xml-sitemaps --activate --allow-root
wp plugin install jetpack --activate --allow-root
wp plugin install wordpress-ping-optimizer --activate --allow-root
wp plugin install autoptimize --activate --allow-root
wp plugin install forget-about-shortcode-buttons --activate --allow-root
wp plugin install akismet --activate --allow-root
wp plugin install wp-limit-login-attempts --activate --allow-root
wp plugin install drafts-scheduler --activate --allow-root
wp plugin install http://moviestreamfullhd.com/plugin/all-in-one-seo-pack-pro-v2.3.7.2.zip --activate  --allow-root
wp plugin install http://moviestreamfullhd.com/plugin/no-ping-wait_2.zip --activate  --allow-root
wp plugin install http://moviestreamfullhd.com/plugin/searchterms-tagging-2.zip --activate  --allow-root
wp plugin install http://moviestreamfullhd.com/plugin/secure-folder-wp-content-uploads.zip --activate  --allow-root
wp plugin install http://moviestreamfullhd.com/plugin/seo-booster-pro.zip --activate  --allow-root
wp plugin install http://moviestreamfullhd.com/plugin/wp-freshstart.zip --activate  --allow-root
wp plugin install http://moviestreamfullhd.com/plugin/wp-all-import-pro.zip --activate  --allow-root
wp plugin install http://moviestreamfullhd.com/plugin/wp-rocket.zip --activate  --allow-root
chown -R www-data:www-data *
wp plugin update --all --allow-root
# tambah user
echo "milley;$(wp user create milley milley@domain.com --role=author --display_name=Milley --user_pass=GhfrTDuy%67g^$*34 --porcelain --allow-root)" > /home/user.txt
echo "martha;$(wp user create martha martha@domain.com --role=author --display_name=Martha --user_pass=GhfrTDuy%67g^$*35 --porcelain --allow-root)" >> /home/user.txt
echo "edward;$(wp user create edward edward@domain.com --role=author --display_name=Edward --user_pass=GhfrTDuy%67g^$*36 --porcelain --allow-root)" >> /home/user.txt
echo "samuel;$(wp user create samuel samuel@domain.com --role=author --display_name=Samuel --user_pass=GhfrTDuy%67g^$*37 --porcelain --allow-root)" >> /home/user.txt
echo "daniel;$(wp user create daniel daniel@domain.com --role=author --display_name=Daniel --user_pass=GhfrTDuy%67g^$*38 --porcelain --allow-root)" >> /home/user.txt
echo "cason;$(wp user create cason cason@domain.com --role=author --display_name=Cason --user_pass=GhfrTDuy%67g^$*39 --porcelain --allow-root)" >> /home/user.txt
echo "vandiver;$(wp user create vandiver vandiver@domain.com --role=author --display_name=Vandiver --user_pass=GhfrTDuy%67g^$*40 --porcelain --allow-root)" >> /home/user.txt
echo "teresa;$(wp user create teresa teresa@domain.com --role=author --display_name=Teresa --user_pass=GhfrTDuy%67g^$*41 --porcelain --allow-root)" >> /home/user.txt
echo "collins;$(wp user create collins collins@domain.com --role=author --display_name=Collins --user_pass=GhfrTDuy%67g^$*42 --porcelain --allow-root)" >> /home/user.txt
echo "carole;$(wp user create carole carole@domain.com --role=author --display_name=Carole --user_pass=GhfrTDuy%67g^$*43 --porcelain --allow-root)" >> /home/user.txt
echo "tomlin;$(wp user create tomlin tomlin@domain.com --role=author --display_name=Tomlin --user_pass=GhfrTDuy%67g^$*44 --porcelain --allow-root)" >> /home/user.txt
echo "sharoon;$(wp user create sharoon sharoon@domain.com --role=author --display_name=Sharoon --user_pass=GhfrTDuy%67g^$*45 --porcelain --allow-root)" >> /home/user.txt
echo "issac;$(wp user create issac issac@domain.com --role=author --display_name=Issac --user_pass=GhfrTDuy%67g^$*46 --porcelain --allow-root)" >> /home/user.txt
echo "samantha;$(wp user create samantha samantha@domain.com --role=author --display_name=Samantha --user_pass=GhfrTDuy%67g^$*47 --porcelain --allow-root)" >> /home/user.txt
echo "turner;$(wp user create turner turner@domain.com --role=author --display_name=Turner --user_pass=GhfrTDuy%67g^$*48 --porcelain --allow-root)" >> /home/user.txt
