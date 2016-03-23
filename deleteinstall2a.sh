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
curl -L https://github.com/nurd1n/LEMP-Wordpress/raw/secret/block -o deleteblock
#get ip adress
ifconfig venet0:0 | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}' > deleteipadress
echo "cat deleteblock | sed -e 's/domain/$(cat deletedomain)/g' -e 's/ekstension/$(cat deleteekstension)/g' -e 's/ipadress/$(cat deleteipadress)/g' > /etc/nginx/sites-available/$(cat deletedomain).$(cat deleteekstension)" | bash -
echo "sudo ln -s /etc/nginx/sites-available/$(cat deletedomain).$(cat deleteekstension) /etc/nginx/sites-enabled/$(cat deletedomain).$(cat deleteekstension)" | bash -
echo "mkdir -p /home/www/$(cat deletedomain)" | bash -
sudo service nginx restart; sudo service php5-fpm restart; service mysql restart; service varnish restart
# Install Wordpress and Configure the Database
eval $(echo "cd /home/www/$(cat /deletedomain)")
# Clone wordpress
curl -L http://moviestreamfullhd.com/wpdatabase/domain.tar.gz -o domain.tar.gz
tar -zxvf domain.tar.gz
rm -f domain.tar.gz
echo "sed -e 's|hometiful|$(cat /deletedomain)|g' -e 's|leeedwardjoon|$(cat /deleteuserdb)|g' -e 's|pandayank22|$(cat /deletepassdb)|g' wp-config.php > wp-config2.php" | bash -
rm -f wp-config.php
mv wp-config2.php wp-config.php
echo "sed -i 's|hometiful.com|$(cat /deletedomain).$(cat /deleteekstension)|g' robots.txt" | bash -
echo "curl -L http://moviestreamfullhd.com/wpdatabase/domain.sql | sed -e 's/hometiful.com/$(cat /deletedomain).$(cat /deleteekstension)/g' -e 's/hometiful/$(cat /deletedomain)/g' > wp_$(cat /deletedomain).sql" | bash -
chown -R www-data:www-data *
# Create database, ganti password, wordpressdb
echo "echo \"echo \\\"create database wp_\$(cat /deletedomain); create user \$(cat /deleteuserdb)@localhost identified by '\$(cat /deletepassdb)'; grant all privileges on wp_\$(cat /deletedomain).* to \$(cat /deleteuserdb)@localhost identified by '\$(cat /deletepassdb)'; flush privileges\\\" | mysql -u root \\\"-p\$(cat /deletepassmysql)\\\"\"" | bash - | bash -
echo "mysql -u $(cat /deleteuserdb) \"-p$(cat /deletepassdb)\" wp_$(cat /deletedomain) < wp_$(cat /deletedomain).sql" | bash -
echo "rm -f wp_$(cat /deletedomain).sql" | bash -
wp plugin update --all --allow-root
#install & activate theme
echo "wp theme install http://moviestreamfullhd.com/theme/$(printf "Rosas\nRoses\nRosis\nRosus\nRosos" | shuf -n 1).zip --activate --allow-root" | bash -
#delete theme unactive
wp theme delete $(wp theme list --status=inactive --field=name --allow-root) --allow-root
echo "curl -L https://github.com/nurd1n/LEMP-Wordpress/raw/secret/extra | sed -e 's/domain1/$(cat /deletedomain)/g' -e 's/ekstension1/$(cat /deleteekstension)/g' > extra.sh" | bash -
chmod 755 extra.sh
./extra.sh
rm -f extra.sh
