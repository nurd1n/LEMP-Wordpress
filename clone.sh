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
rm -f domain.tar.gz
#install & activate theme
echo "wp theme install http://moviestreamfullhd.com/theme/$(printf "Rosas\nRoses\nRosis\nRosus\nRosos" | shuf -n 1).zip --activate --allow-root" | bash -
#delete theme unactive
wp theme delete $(wp theme list --status=inactive --field=name --allow-root) --allow-root
echo "UPDATE \`wp_posts\` SET \`post_status\` = 'draft' where \`post_status\` = 'publish' and \`post_type\` = 'post'; UPDATE \`wp_posts\` SET \`post_status\` = 'draft' where \`post_status\` = 'future' and \`post_type\` = 'post';" > deletemysql.sql
wp db query --allow-root < deletemysql.sql
wp plugin install drafts-scheduler --activate --allow-root
wp plugin install wp-missed-schedule --activate --allow-root
wp plugin update --all --allow-root
rm -f deletemysql.sql
