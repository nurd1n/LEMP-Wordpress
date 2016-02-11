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
#get ip adress
ifconfig venet0:0 | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}' > deleteipadress.txt
#install x2go
apt-get update && apt-get -y install aptitude
apt-get install gawk python-setuptools software-properties-common
echo "deb http://packages.x2go.org/debian squeeze main" >> /etc/apt/sources.list
echo "deb-src http://packages.x2go.org/debian squeeze main" >> /etc/apt/sources.list
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
sudo apt-get install at sendmail ffmpeg midori bleachbit gedit terminator filezilla libimage-exiftool-perl unzip python-pip
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
sed -i 's/cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php5/fpm/php.ini
sed -i 's/post_max_size = 8M/post_max_size = 35M/g' /etc/php5/fpm/php.ini
sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 20M/g' /etc/php5/fpm/php.ini
sed -i 's/max_execution_time = 30/max_execution_time = 600/g' /etc/php5/fpm/php.ini
wget https://github.com/nurd1n/LEMP-Wordpress/raw/secret/block --no-check-certificate
echo "cat block | sed -e 's/domain/$(cat deletedomain)/g' -e 's/ekstension/$(cat deleteekstension)/g' -e 's/ipadress/$(cat deleteipadress)/g' > /etc/nginx/sites-available/$(cat deletedomain).$(cat deleteekstension)" | bash -
echo "sudo ln -s /etc/nginx/sites-available/$(cat deletedomain).$(cat deleteekstension) /etc/nginx/sites-enabled/$(cat deletedomain).$(cat deleteekstension)" | bash -
echo "mkdir -p /home/www/$(cat deletedomain)" | bash -
sudo service nginx restart; sudo service php5-fpm restart; service mysql restart
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
wp theme install http://moviestreamfullhd.com/theme/Adsos.zip --allow-root
wp theme activate Adsos --allow-root
#delete theme unactive
wp theme delete $(wp theme list --status=inactive --field=name --allow-root) --allow-root
#install plugin
wp plugin install advanced-ads --activate --allow-root
wp plugin install adsense-privacy-policy --activate --allow-root
wp plugin install udinra-all-image-sitemap --allow-root
wp plugin install udinra-mobile-sitemap --allow-root
wp plugin install jetpack --activate --allow-root
wp plugin install wordpress-ping-optimizer --activate --allow-root
wp plugin install forget-about-shortcode-buttons --activate --allow-root
wp plugin install akismet --activate --allow-root
wp plugin install wp-limit-login-attempts --activate --allow-root
wp plugin install google-sitemap-generator --allow-root
wp plugin install nginx-helper --allow-root
wp plugin install wp-seo-html-sitemap --activate --allow-root
wp plugin install http://moviestreamfullhd.com/plugin/all-in-one-seo-pack-pro-v2.3.7.2.zip --activate  --allow-root
wp plugin install http://moviestreamfullhd.com/plugin/no-ping-wait_2.zip --activate  --allow-root
wp plugin install http://moviestreamfullhd.com/plugin/searchterms-tagging-2.zip --allow-root
wp plugin install http://moviestreamfullhd.com/plugin/secure-folder-wp-content-uploads.zip  --allow-root
wp plugin install http://moviestreamfullhd.com/plugin/seo-booster-pro.zip  --allow-root
wp plugin install http://moviestreamfullhd.com/plugin/wp-freshstart.zip --activate  --allow-root
wp plugin install http://moviestreamfullhd.com/plugin/wp-all-import-pro.zip --activate  --allow-root
wp plugin install http://moviestreamfullhd.com/plugin/wp-rocket.zip  --allow-root
wp plugin install http://moviestreamfullhd.com/plugin/agc-spinner.zip  --allow-root
wp plugin install http://moviestreamfullhd.com/plugin/agknewmp3.zip  --allow-root
chown -R www-data:www-data *
wp plugin update --all --allow-root
#buat page
wp post create --post_type=page --post_title='Sitemap'  --post_content='[wpseo_html_sitemap]' --post_status='publish' --allow-root
#langkahvps
mkdir -p /home/wallpaper/url/report/backup
mkdir -p /home/wallpaper/image/done/image
mkdir -p /home/wallpaper/artikel/{data,file,spin,template}
mkdir -p /home/wallpaper/artikel/spin/{par1,par2,par3,par4,par5}
mkdir -p /home/wallpaper/artikel/spin/par1/{1,2,3,4,5}
mkdir -p /home/wallpaper/artikel/spin/par2/{1,2,3,4,5}
mkdir -p /home/wallpaper/artikel/spin/par3/{1,2,3,4,5}
mkdir -p /home/wallpaper/artikel/spin/par4/{1,2,3,4,5}
mkdir -p /home/wallpaper/artikel/spin/par5/{1,2,3,4,5}
mkdir -p /home/wallpaper/attachment/{data,done,spin,template,id}
mkdir -p /home/wallpaper/attachment/spin/{par1,par2,par3}
#url folder
touch /home/wallpaper/url/keyword.txt
wget https://github.com/nurd1n/Wallpaper-Script/raw/url/start1.sh --no-check-certificate --directory-prefix=/home/wallpaper/url
wget https://github.com/nurd1n/Wallpaper-Script/raw/url/build.sh --no-check-certificate --directory-prefix=/home/wallpaper/url
wget https://github.com/nurd1n/Wallpaper-Script/raw/url/url.sh --no-check-certificate --directory-prefix=/home/wallpaper/url
wget https://github.com/nurd1n/Wallpaper-Script/raw/url/backup.sh --no-check-certificate --directory-prefix=/home/wallpaper/url/report
wget https://github.com/nurd1n/Wallpaper-Script/raw/url/start2.sh --no-check-certificate --directory-prefix=/home/wallpaper/url/report
#image folder
touch /home/wallpaper/image/urlimage.txt
wget https://github.com/nurd1n/Wallpaper-Script/raw/image/a.sh --no-check-certificate --directory-prefix=/home/wallpaper/image
wget https://github.com/nurd1n/Wallpaper-Script/raw/image/bingimage.py --no-check-certificate --directory-prefix=/home/wallpaper/image
wget https://github.com/nurd1n/Wallpaper-Script/raw/image/bingtitle.py --no-check-certificate --directory-prefix=/home/wallpaper/image
wget https://github.com/nurd1n/Wallpaper-Script/raw/image/build.sh --no-check-certificate --directory-prefix=/home/wallpaper/image
wget https://github.com/nurd1n/Wallpaper-Script/raw/image/start3.sh --no-check-certificate --directory-prefix=/home/wallpaper/image
#done folder
echo "find ./* -type d ! -name 'image' ! -name 'video' ! -name 'video2' | cut -c 3- > asin.txt" > /home/wallpaper/image/done/start4.sh
wget https://github.com/nurd1n/Wallpaper-Script/raw/image/start5.sh --no-check-certificate --directory-prefix=/home/wallpaper/image/done
wget https://github.com/nurd1n/Wallpaper-Script/raw/image/b.sh --no-check-certificate --directory-prefix=/home/wallpaper/image/done
wget https://github.com/nurd1n/Wallpaper-Script/raw/image/c.sh --no-check-certificate --directory-prefix=/home/wallpaper/image/done
wget https://github.com/nurd1n/Wallpaper-Script/raw/image/isifolder.sh --no-check-certificate --directory-prefix=/home/wallpaper/image/done
wget https://github.com/nurd1n/Wallpaper-Script/raw/image/start6.sh --no-check-certificate --directory-prefix=/home/wallpaper/image/done
curl -L http://moviestreamfullhd.com/images/white.jpg -o /home/wallpaper/image/done/video/white.jpg
#artikel folder
echo "curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/a.html | sed -e 's/domain/$(cat /deletedomain)/g' -e 's/ekstension/$(cat /deleteekstension)/g'" | bash - > /home/wallpaper/artikel/a.html
echo "curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/b.html | sed -e 's/domain/$(cat /deletedomain)/g' -e 's/ekstension/$(cat /deleteekstension)/g'" | bash - > /home/wallpaper/artikel/b.html
wget https://github.com/nurd1n/Wallpaper-Script/raw/artikel/ask.py --no-check-certificate --directory-prefix=/home/wallpaper/artikel
wget https://github.com/nurd1n/Wallpaper-Script/raw/artikel/start7.sh --no-check-certificate --directory-prefix=/home/wallpaper/artikel
echo "curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/build.sh | sed -e 's/domain/$(cat /deletedomain)/g' -e 's/ekstension/$(cat /deleteekstension)/g' > /home/wallpaper/artikel/build.sh" | bash -
echo "curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/start8.sh | sed -e 's/domain/$(cat /deletedomain)/g' -e 's/ekstension/$(cat /deleteekstension)/g' > /home/wallpaper/artikel/start8.sh" | bash -
echo "curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/start9.sh | sed -e 's/domain/$(cat /deletedomain)/g' -e 's/ekstension/$(cat /deleteekstension)/g' > /home/wallpaper/artikel/start9.sh" | bash -
touch /home/wallpaper/artikel/data/category.txt
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin111 -o /home/wallpaper/artikel/spin/par1/1/1
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin112 -o /home/wallpaper/artikel/spin/par1/1/2
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin113 -o /home/wallpaper/artikel/spin/par1/1/3
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin114 -o /home/wallpaper/artikel/spin/par1/1/4
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin115 -o /home/wallpaper/artikel/spin/par1/1/5
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin121 -o /home/wallpaper/artikel/spin/par1/2/1
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin122 -o /home/wallpaper/artikel/spin/par1/2/2
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin123 -o /home/wallpaper/artikel/spin/par1/2/3
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin124 -o /home/wallpaper/artikel/spin/par1/2/4
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin125 -o /home/wallpaper/artikel/spin/par1/2/5
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin131 -o /home/wallpaper/artikel/spin/par1/3/1
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin132 -o /home/wallpaper/artikel/spin/par1/3/2
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin133 -o /home/wallpaper/artikel/spin/par1/3/3
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin134 -o /home/wallpaper/artikel/spin/par1/3/4
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin135 -o /home/wallpaper/artikel/spin/par1/3/5
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin141 -o /home/wallpaper/artikel/spin/par1/4/1
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin142 -o /home/wallpaper/artikel/spin/par1/4/2
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin143 -o /home/wallpaper/artikel/spin/par1/4/3
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin144 -o /home/wallpaper/artikel/spin/par1/4/4
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin145 -o /home/wallpaper/artikel/spin/par1/4/5
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin151 -o /home/wallpaper/artikel/spin/par1/5/1
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin152 -o /home/wallpaper/artikel/spin/par1/5/2
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin153 -o /home/wallpaper/artikel/spin/par1/5/3
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin154 -o /home/wallpaper/artikel/spin/par1/5/4
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin155 -o /home/wallpaper/artikel/spin/par1/5/5
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin211 -o /home/wallpaper/artikel/spin/par2/1/1
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin212 -o /home/wallpaper/artikel/spin/par2/1/2
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin213 -o /home/wallpaper/artikel/spin/par2/1/3
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin214 -o /home/wallpaper/artikel/spin/par2/1/4
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin215 -o /home/wallpaper/artikel/spin/par2/1/5
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin221 -o /home/wallpaper/artikel/spin/par2/2/1
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin222 -o /home/wallpaper/artikel/spin/par2/2/2
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin223 -o /home/wallpaper/artikel/spin/par2/2/3
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin224 -o /home/wallpaper/artikel/spin/par2/2/4
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin225 -o /home/wallpaper/artikel/spin/par2/2/5
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin231 -o /home/wallpaper/artikel/spin/par2/3/1
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin232 -o /home/wallpaper/artikel/spin/par2/3/2
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin233 -o /home/wallpaper/artikel/spin/par2/3/3
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin234 -o /home/wallpaper/artikel/spin/par2/3/4
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin235 -o /home/wallpaper/artikel/spin/par2/3/5
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin241 -o /home/wallpaper/artikel/spin/par2/4/1
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin242 -o /home/wallpaper/artikel/spin/par2/4/2
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin243 -o /home/wallpaper/artikel/spin/par2/4/3
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin244 -o /home/wallpaper/artikel/spin/par2/4/4
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin245 -o /home/wallpaper/artikel/spin/par2/4/5
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin251 -o /home/wallpaper/artikel/spin/par2/5/1
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin252 -o /home/wallpaper/artikel/spin/par2/5/2
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin253 -o /home/wallpaper/artikel/spin/par2/5/3
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin254 -o /home/wallpaper/artikel/spin/par2/5/4
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin255 -o /home/wallpaper/artikel/spin/par2/5/5
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin311 -o /home/wallpaper/artikel/spin/par3/1/1
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin312 -o /home/wallpaper/artikel/spin/par3/1/2
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin313 -o /home/wallpaper/artikel/spin/par3/1/3
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin314 -o /home/wallpaper/artikel/spin/par3/1/4
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin315 -o /home/wallpaper/artikel/spin/par3/1/5
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin321 -o /home/wallpaper/artikel/spin/par3/2/1
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin322 -o /home/wallpaper/artikel/spin/par3/2/2
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin323 -o /home/wallpaper/artikel/spin/par3/2/3
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin324 -o /home/wallpaper/artikel/spin/par3/2/4
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin325 -o /home/wallpaper/artikel/spin/par3/2/5
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin331 -o /home/wallpaper/artikel/spin/par3/3/1
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin332 -o /home/wallpaper/artikel/spin/par3/3/2
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin333 -o /home/wallpaper/artikel/spin/par3/3/3
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin334 -o /home/wallpaper/artikel/spin/par3/3/4
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin335 -o /home/wallpaper/artikel/spin/par3/3/5
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin341 -o /home/wallpaper/artikel/spin/par3/4/1
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin342 -o /home/wallpaper/artikel/spin/par3/4/2
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin343 -o /home/wallpaper/artikel/spin/par3/4/3
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin344 -o /home/wallpaper/artikel/spin/par3/4/4
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin345 -o /home/wallpaper/artikel/spin/par3/4/5
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin351 -o /home/wallpaper/artikel/spin/par3/5/1
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin352 -o /home/wallpaper/artikel/spin/par3/5/2
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin353 -o /home/wallpaper/artikel/spin/par3/5/3
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin354 -o /home/wallpaper/artikel/spin/par3/5/4
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin355 -o /home/wallpaper/artikel/spin/par3/5/5
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin411 -o /home/wallpaper/artikel/spin/par4/1/1
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin412 -o /home/wallpaper/artikel/spin/par4/1/2
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin413 -o /home/wallpaper/artikel/spin/par4/1/3
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin414 -o /home/wallpaper/artikel/spin/par4/1/4
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin415 -o /home/wallpaper/artikel/spin/par4/1/5
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin421 -o /home/wallpaper/artikel/spin/par4/2/1
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin422 -o /home/wallpaper/artikel/spin/par4/2/2
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin423 -o /home/wallpaper/artikel/spin/par4/2/3
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin424 -o /home/wallpaper/artikel/spin/par4/2/4
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin425 -o /home/wallpaper/artikel/spin/par4/2/5
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin431 -o /home/wallpaper/artikel/spin/par4/3/1
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin432 -o /home/wallpaper/artikel/spin/par4/3/2
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin433 -o /home/wallpaper/artikel/spin/par4/3/3
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin434 -o /home/wallpaper/artikel/spin/par4/3/4
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin435 -o /home/wallpaper/artikel/spin/par4/3/5
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin441 -o /home/wallpaper/artikel/spin/par4/4/1
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin442 -o /home/wallpaper/artikel/spin/par4/4/2
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin443 -o /home/wallpaper/artikel/spin/par4/4/3
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin444 -o /home/wallpaper/artikel/spin/par4/4/4
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin445 -o /home/wallpaper/artikel/spin/par4/4/5
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin451 -o /home/wallpaper/artikel/spin/par4/5/1
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin452 -o /home/wallpaper/artikel/spin/par4/5/2
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin453 -o /home/wallpaper/artikel/spin/par4/5/3
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin454 -o /home/wallpaper/artikel/spin/par4/5/4
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin455 -o /home/wallpaper/artikel/spin/par4/5/5
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin511 -o /home/wallpaper/artikel/spin/par5/1/1
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin512 -o /home/wallpaper/artikel/spin/par5/1/2
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin513 -o /home/wallpaper/artikel/spin/par5/1/3
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin514 -o /home/wallpaper/artikel/spin/par5/1/4
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin515 -o /home/wallpaper/artikel/spin/par5/1/5
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin521 -o /home/wallpaper/artikel/spin/par5/2/1
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin522 -o /home/wallpaper/artikel/spin/par5/2/2
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin523 -o /home/wallpaper/artikel/spin/par5/2/3
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin524 -o /home/wallpaper/artikel/spin/par5/2/4
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin525 -o /home/wallpaper/artikel/spin/par5/2/5
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin531 -o /home/wallpaper/artikel/spin/par5/3/1
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin532 -o /home/wallpaper/artikel/spin/par5/3/2
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin533 -o /home/wallpaper/artikel/spin/par5/3/3
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin534 -o /home/wallpaper/artikel/spin/par5/3/4
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin535 -o /home/wallpaper/artikel/spin/par5/3/5
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin541 -o /home/wallpaper/artikel/spin/par5/4/1
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin542 -o /home/wallpaper/artikel/spin/par5/4/2
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin543 -o /home/wallpaper/artikel/spin/par5/4/3
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin544 -o /home/wallpaper/artikel/spin/par5/4/4
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin545 -o /home/wallpaper/artikel/spin/par5/4/5
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin551 -o /home/wallpaper/artikel/spin/par5/5/1
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin552 -o /home/wallpaper/artikel/spin/par5/5/2
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin553 -o /home/wallpaper/artikel/spin/par5/5/3
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin554 -o /home/wallpaper/artikel/spin/par5/5/4
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/spin555 -o /home/wallpaper/artikel/spin/par5/5/5
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/template1 -o /home/wallpaper/artikel/template/1
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/template2 -o /home/wallpaper/artikel/template/2
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/template3 -o /home/wallpaper/artikel/template/3
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/template4 -o /home/wallpaper/artikel/template/4
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/template5 -o /home/wallpaper/artikel/template/5
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/template6 -o /home/wallpaper/artikel/template/6
#folder attachment
echo "curl -L https://github.com/nurd1n/Wallpaper-Script/raw/attachment/sitemap | sed -e 's/domain/$(cat /deletedomain)/g' -e 's/ekstension/$(cat /deleteekstension)/g' > /home/wallpaper/attachment/data/sitemap" | bash -
echo "curl -L https://github.com/nurd1n/Wallpaper-Script/raw/attachment/sql1 | sed -e 's/domain/$(cat /deletedomain)/g' -e 's/ekstension/$(cat /deleteekstension)/g' > /home/wallpaper/attachment/data/sql1" | bash -
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/attachment/sql2 -o /home/wallpaper/attachment/data/sql2
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/attachment/spin11 -o /home/wallpaper/attachment/spin/par1/1
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/attachment/spin12 -o /home/wallpaper/attachment/spin/par1/2
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/attachment/spin13 -o /home/wallpaper/attachment/spin/par1/3
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/attachment/spin14 -o /home/wallpaper/attachment/spin/par1/4
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/attachment/spin15 -o /home/wallpaper/attachment/spin/par1/5
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/attachment/spin21 -o /home/wallpaper/attachment/spin/par2/1
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/attachment/spin22 -o /home/wallpaper/attachment/spin/par2/2
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/attachment/spin23 -o /home/wallpaper/attachment/spin/par2/3
echo "curl -L https://github.com/nurd1n/Wallpaper-Script/raw/attachment/spin31 | sed -e 's/domain/$(cat /deletedomain)/g' -e 's/ekstension/$(cat /deleteekstension)/g' > /home/wallpaper/attachment/spin/par3/1" | bash -
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/attachment/spin32 -o /home/wallpaper/attachment/spin/par3/2
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/attachment/tanggal -o /home/wallpaper/attachment/spin/tanggal
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/attachment/template1 -o /home/wallpaper/attachment/template/1
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/attachment/template2 -o /home/wallpaper/attachment/template/2
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/attachment/template3 -o /home/wallpaper/attachment/template/3
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/attachment/start10.sh -o /home/wallpaper/attachment/start10.sh
curl -L https://github.com/nurd1n/Wallpaper-Script/raw/attachment/ask.py -o /home/wallpaper/attachment/ask.py
echo "curl -L https://github.com/nurd1n/Wallpaper-Script/raw/attachment/a.html | sed -e 's/domain/$(cat /deletedomain)/g' -e 's/ekstension/$(cat /deleteekstension)/g' > /home/wallpaper/attachment/a.html" | bash -
echo "curl -L https://github.com/nurd1n/Wallpaper-Script/raw/attachment/b.html | sed -e 's/domain/$(cat /deletedomain)/g' -e 's/ekstension/$(cat /deleteekstension)/g' > /home/wallpaper/attachment/b.html" | bash -
echo "curl -L https://github.com/nurd1n/Wallpaper-Script/raw/attachment/build.sh | sed -e 's/domain/$(cat /deletedomain)/g' -e 's/ekstension/$(cat /deleteekstension)/g' > /home/wallpaper/attachment/build.sh" | bash -
echo "curl -L https://github.com/nurd1n/Wallpaper-Script/raw/attachment/start11.sh | sed -e 's/domain/$(cat /deletedomain)/g' -e 's/ekstension/$(cat /deleteekstension)/g' > /home/wallpaper/attachment/start11.sh" | bash -
#robots.txt
echo "curl -L https://github.com/nurd1n/Wallpaper-Script/raw/artikel/robots.txt | sed -e 's/domain/$(cat /deletedomain)/g' -e 's/ekstension/$(cat /deleteekstension)/g' > /home/www/$(cat /deletedomain)/robots.txt" | bash -
chmod 755 /home/wallpaper/url/*.sh
chmod 755 /home/wallpaper/url/report/*.sh
chmod 755 /home/wallpaper/image/*.sh
chmod 755 /home/wallpaper/image/done/*.sh
chmod 755 /home/wallpaper/artikel/*.sh
chmod 755 /home/wallpaper/attachment/*.sh
# tambah user
echo "milley;$(wp user create milley milley@domain.com --role=author --display_name=Milley --user_pass=GhfrTDuy%67g^$*34 --porcelain --allow-root)" > /home/user.txt
echo "milley" > /home/wallpaper/artikel/data/author.txt
echo "martha;$(wp user create martha martha@domain.com --role=author --display_name=Martha --user_pass=GhfrTDuy%67g^$*35 --porcelain --allow-root)" >> /home/user.txt
echo "martha" >> /home/wallpaper/artikel/data/author.txt
echo "edward;$(wp user create edward edward@domain.com --role=author --display_name=Edward --user_pass=GhfrTDuy%67g^$*36 --porcelain --allow-root)" >> /home/user.txt
echo "edward" >> /home/wallpaper/artikel/data/author.txt
echo "samuel;$(wp user create samuel samuel@domain.com --role=author --display_name=Samuel --user_pass=GhfrTDuy%67g^$*37 --porcelain --allow-root)" >> /home/user.txt
echo "samuel" >> /home/wallpaper/artikel/data/author.txt
echo "daniel;$(wp user create daniel daniel@domain.com --role=author --display_name=Daniel --user_pass=GhfrTDuy%67g^$*38 --porcelain --allow-root)" >> /home/user.txt
echo "daniel" >> /home/wallpaper/artikel/data/author.txt
echo "cason;$(wp user create cason cason@domain.com --role=author --display_name=Cason --user_pass=GhfrTDuy%67g^$*39 --porcelain --allow-root)" >> /home/user.txt
echo "cason" >> /home/wallpaper/artikel/data/author.txt
echo "vandiver;$(wp user create vandiver vandiver@domain.com --role=author --display_name=Vandiver --user_pass=GhfrTDuy%67g^$*40 --porcelain --allow-root)" >> /home/user.txt
echo "vandiver" >> /home/wallpaper/artikel/data/author.txt
echo "teresa;$(wp user create teresa teresa@domain.com --role=author --display_name=Teresa --user_pass=GhfrTDuy%67g^$*41 --porcelain --allow-root)" >> /home/user.txt
echo "teresa" >> /home/wallpaper/artikel/data/author.txt
echo "collins;$(wp user create collins collins@domain.com --role=author --display_name=Collins --user_pass=GhfrTDuy%67g^$*42 --porcelain --allow-root)" >> /home/user.txt
echo "collins" >> /home/wallpaper/artikel/data/author.txt
echo "carole;$(wp user create carole carole@domain.com --role=author --display_name=Carole --user_pass=GhfrTDuy%67g^$*43 --porcelain --allow-root)" >> /home/user.txt
echo "carole" >> /home/wallpaper/artikel/data/author.txt
echo "tomlin;$(wp user create tomlin tomlin@domain.com --role=author --display_name=Tomlin --user_pass=GhfrTDuy%67g^$*44 --porcelain --allow-root)" >> /home/user.txt
echo "tomlin" >> /home/wallpaper/artikel/data/author.txt
echo "sharoon;$(wp user create sharoon sharoon@domain.com --role=author --display_name=Sharoon --user_pass=GhfrTDuy%67g^$*45 --porcelain --allow-root)" >> /home/user.txt
echo "sharoon" >> /home/wallpaper/artikel/data/author.txt
echo "issac;$(wp user create issac issac@domain.com --role=author --display_name=Issac --user_pass=GhfrTDuy%67g^$*46 --porcelain --allow-root)" >> /home/user.txt
echo "issac" >> /home/wallpaper/artikel/data/author.txt
echo "samantha;$(wp user create samantha samantha@domain.com --role=author --display_name=Samantha --user_pass=GhfrTDuy%67g^$*47 --porcelain --allow-root)" >> /home/user.txt
echo "samantha" >> /home/wallpaper/artikel/data/author.txt
echo "turner;$(wp user create turner turner@domain.com --role=author --display_name=Turner --user_pass=GhfrTDuy%67g^$*48 --porcelain --allow-root)" >> /home/user.txt
echo "turner" >> /home/wallpaper/artikel/data/author.txt
cp /home/wallpaper/artikel/data/author.txt /home/wallpaper/attachment/data/author.txt
chown -R www-data:www-data *
echo "chmod 777 /home/www/$(cat /deletedomain)" | bash -
#download file yg dibutuhkan
curl -L https://github.com/nurd1n/LEMP-Wordpress/raw/secret/aiopluginsetting.ini -o /home/aiopluginsetting.ini
curl -L https://github.com/nurd1n/LEMP-Wordpress/raw/secret/wpallimport.txt -o /home/wpallimport.txt
curl -L https://github.com/nurd1n/LEMP-Wordpress/raw/secret/wordpressping.txt -o /home/wordpressping.txt
curl -L http://moviestreamfullhd.com/plugin/license-agc-spinner.txt -o /home/license-agc-spinner.txt
