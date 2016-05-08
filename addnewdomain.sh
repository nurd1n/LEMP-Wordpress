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
#untuk data clone
mkdir -p /home/clone2
cat /deletedomain >> /home/clone2/domainawal
cat /deleteekstension >> /home/clone2/ekstensionawal
cat /deleteinisial >> /home/clone2/inisialawal
cat /deleteuserdb >> /home/clone2/userdbawal
cat /deletepassdb >> /home/clone2/passdbawal
curl -L https://github.com/nurd1n/LEMP-Wordpress/raw/secret/block -o deleteblock
#get ip adress
curl -s http://ipv4.icanhazip.com > deleteipadress
echo "cat deleteblock | sed -e 's/domain/$(cat deletedomain)/g' -e 's/ekstension/$(cat deleteekstension)/g' -e 's/ipadress/$(cat deleteipadress)/g' > /etc/nginx/sites-available/$(cat deletedomain).$(cat deleteekstension)" | bash -
echo "sudo ln -s /etc/nginx/sites-available/$(cat deletedomain).$(cat deleteekstension) /etc/nginx/sites-enabled/$(cat deletedomain).$(cat deleteekstension)" | bash -
echo "mkdir -p /home/www/$(cat deletedomain)" | bash -
sudo service nginx restart; sudo service php5-fpm restart; service mysql restart; service varnish restart
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
echo "curl -L http://moviestreamfullhd.com/theme/$(cat /deletetheme).zip -o /home/www/$(cat /deletedomain)/wp-content/themes/$(cat /deletetheme).zip" | bash -
eval $(echo "cd /home/www/$(cat /deletedomain)/wp-content/themes")
echo "unzip $(cat /deletetheme)" | bash -
echo "rm -f $(cat /deletetheme).zip" | bash -
tr -cd '[:alpha:]' < /dev/urandom | fold -w10 | head -n1 | sed -e 's/+/ /g' -e 's/.*/\L&/; s/[a-z]*/\u&/g'> /deletenametheme
echo "mv $(cat /deletetheme) $(cat /deletenametheme)" | bash -
echo "sed -i 's|$(cat /deletetheme)|$(cat /deletenametheme)|g' /home/www/$(cat /deletedomain)/wp-content/themes/$(cat /deletenametheme)/style.css" | bash -
echo "mv $(cat /deletenametheme)/style.css $(cat /deletenametheme)/style2.css" | bash -
echo "shuf $(cat /deletenametheme)/style2.css > $(cat /deletenametheme)/style.css" | bash -
echo "rm -f $(cat /deletenametheme)/style2.css" | bash -
curl -L https://github.com/nurd1n/LEMP-Wordpress/raw/secret/responsive1 | shuf | awk 'FNR==1{print "@media only screen and (min-width: 768px) and (max-width: 960px) {"}{print}' | sed '$ a }' > /deletethemeres
curl -L https://github.com/nurd1n/LEMP-Wordpress/raw/secret/responsive2 | shuf | awk 'FNR==1{print "@media only screen and (max-width: 767px) {"}{print}' | sed '$ a }' >> /deletethemeres
curl -L https://github.com/nurd1n/LEMP-Wordpress/raw/secret/responsive3 | shuf | awk 'FNR==1{print "@media only screen and (min-width: 480px) and (max-width: 767px) {"}{print}' | sed '$ a }' >> /deletethemeres
echo "cat /deletethemeres | awk 'FNR==1{print \"/* Theme Name: $(cat /deletenametheme) */\"}{print}' > /home/www/$(cat /deletedomain)/wp-content/themes/$(cat /deletenametheme)/responsive.css" | bash -
eval $(echo "cd /home/www/$(cat /deletedomain)")
echo "wp theme activate $(cat /deletenametheme) --allow-root" | bash -
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
wp plugin install https://github.com/pkhamre/wp-varnish/archive/master.zip --activate  --allow-root
chown -R www-data:www-data *
wp plugin update --all --allow-root
#buat page
wp post create --post_type=page --post_title='Sitemap'  --post_content='[wpseo_html_sitemap]' --post_status='publish' --allow-root
echo "curl -L https://github.com/nurd1n/LEMP-Wordpress/raw/secret/extra | sed -e 's/domain1/$(cat /deletedomain)/g' -e 's/ekstension1/$(cat /deleteekstension)/g' > extra.sh" | bash -
chmod 755 extra.sh
./extra.sh
rm -f extra.sh
echo "chmod 777 /home/www/$(cat /deletedomain)" | bash -
