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
tr -cd '[:alnum:]' < /dev/urandom | fold -w20 | head -n1 > deleteuserdb; clear
tr -cd '[:alnum:]' < /dev/urandom | fold -w20 | head -n1 > deletepassdb; clear
echo "user db wp : $(cat /deleteuserdb)" >> /home/database.txt
echo "pass db wp : $(cat /deletepassdb)" >> /home/database.txt
echo "leeedwardjoon" > deleteuserwp; clear
echo "leeedwardjoon" > deletepasswp; clear
echo "leeedwardjoon@gmail.com" > deleteemailwp; clear
curl -L https://github.com/nurd1n/LEMP-Wordpress/raw/secret/block -o deleteblock
#get ip adress
ifconfig venet0:0 | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}' > deleteipadress
echo "cat deleteblock | sed -e 's/domain/$(cat deletedomain)/g' -e 's/ekstension/$(cat deleteekstension)/g' -e 's/ipadress/$(cat deleteipadress)/g' > /etc/nginx/sites-available/$(cat deletedomain).$(cat deleteekstension)" | bash -
echo "sudo ln -s /etc/nginx/sites-available/$(cat deletedomain).$(cat deleteekstension) /etc/nginx/sites-enabled/$(cat deletedomain).$(cat deleteekstension)" | bash -
echo "mkdir -p /home/www/$(cat deletedomain)" | bash -
sudo service nginx restart; sudo service php5-fpm restart; service mysql restart; service varnish restart
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
printf "Rosas\nRoses\nRosis\nRosus\nRosos" | shuf -n 1 > /deletetheme
echo "wp theme install http://moviestreamfullhd.com/theme/$(cat /deletetheme).zip --activate --allow-root" | bash -
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
wp plugin install nginx-helper --allow-root
wp plugin install nginx-compatibility --activate --allow-root
wp plugin install wp-seo-html-sitemap --activate --allow-root
wp plugin install http://moviestreamfullhd.com/plugin/all-in-one-seo-pack-pro-v2.3.7.2.zip --activate  --allow-root
wp plugin install http://moviestreamfullhd.com/plugin/no-ping-wait_2.zip --activate --allow-root
wp plugin install http://moviestreamfullhd.com/plugin/wp-freshstart.zip --activate  --allow-root
wp plugin install http://moviestreamfullhd.com/plugin/wp-all-import-pro.zip --activate  --allow-root
wp plugin install https://github.com/pkhamre/wp-varnish/archive/master.zip --activate --allow-root
chown -R www-data:www-data *
echo "curl -L https://github.com/nurd1n/LEMP-Wordpress/raw/secret/extra | sed -e 's/domain1/$(cat /deletedomain)/g' -e 's/ekstension1/$(cat /deleteekstension)/g' > extra.sh" | bash -
chmod 755 extra.sh
./extra.sh
rm -f extra.sh
echo "curl -L http://moviestreamfullhd.com/wpdatabase/domain.sql | sed -e 's/lailykitchen.xyz/$(cat /deletedomain).$(cat /deleteekstension)/g' -e 's/lailykitchen/$(cat /deletedomain)/g' > wp_$(cat /deletedomain).sql" | bash -
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
