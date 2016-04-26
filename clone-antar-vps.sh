cd /
clear && clear
echo -n "Apa ip lama anda :
"
read ipawal
echo "$ipawal" > deleteipawal; clear
echo -n "Apa nama domain lama anda (tanpa dot com) :
"
read domainawal
echo "$domainawal" > deletedomainawal; clear
echo -n "Apa nama ekstension domain lama anda (com, net, org, xyz, dll) :
"
read ekstensionawal
echo "$ekstensionawal" > deleteekstensionawal; clear
echo -n "Apa user database wordpress lama :
"
read userdbawal
echo "$userdbawal" > deleteuserdbawal; clear
echo -n "Apa password database wordpress lama :
"
read passdbawal
echo "$passdbawal" > deletepassdbawal; clear
echo -n "Apa nama domain baru anda (tanpa dot com) :
"
read domainbaru
echo "$domainbaru" > deletedomainbaru; clear
echo -n "Apa nama ekstension domain baru anda (com, net, org, xyz, dll) :
"
read ekstensionbaru
echo "$ekstensionbaru" > deleteekstensionbaru; clear
echo "http://www.$(cat /deletedomainbaru).$(cat /deleteekstensionbaru)" >> /home/database.txt
echo -n "Apa password mysql yg anda inginkan (huruf dan angka) :
"
read passmysql
echo "$passmysql" > deletepassmysql; clear
tr -cd '[:alnum:]' < /dev/urandom | fold -w20 | head -n1 > deleteuserdbbaru; clear
tr -cd '[:alnum:]' < /dev/urandom | fold -w20 | head -n1 > deletepassdbbaru; clear
echo "user db wp : $(cat /deleteuserdbbaru)" >> /home/database.txt
echo "pass db wp : $(cat /deletepassdbbaru)" >> /home/database.txt
curl -L https://github.com/nurd1n/LEMP-Wordpress/raw/secret/block -o deleteblock
#get ip adress
ifconfig venet0:0 | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}' > deleteipadress
echo "cat deleteblock | sed -e 's/domain/$(cat deletedomainbaru)/g' -e 's/ekstension/$(cat deleteekstensionbaru)/g' -e 's/ipadress/$(cat deleteipadress)/g' > /etc/nginx/sites-available/$(cat deletedomainbaru).$(cat deleteekstensionbaru)" | bash -
echo "sudo ln -s /etc/nginx/sites-available/$(cat deletedomainbaru).$(cat deleteekstensionbaru) /etc/nginx/sites-enabled/$(cat deletedomainbaru).$(cat deleteekstensionbaru)" | bash -
echo "mkdir -p /home/www/$(cat deletedomainbaru)" | bash -
sudo service nginx restart; sudo service php5-fpm restart; service mysql restart; service varnish restart
# Clone Wordpress and Configure the Database
eval $(echo "cd /home/www/$(cat /deletedomainbaru)")
# Clone wordpress
echo "curl -L http://$(cat /deleteipawal)/domain-$(cat /deletedomainawal)$(cat /deleteekstensionawal).tar.gz -o domain.tar.gz" | bash -
tar -zxvf domain.tar.gz
echo "sed -e 's|$(cat /deletedomainawal)|$(cat /deletedomainbaru)|g' -e 's|$(cat /deleteuserdbawal)|$(cat /deleteuserdbbaru)|g' -e 's|$(cat /deletepassdbawal)|$(cat /deletepassdbbaru)|g' wp-config.php > wp-config2.php" | bash -
rm -f wp-config.php
mv wp-config2.php wp-config.php
echo "sed -i 's|$(cat /deletedomainawal).$(cat /deleteekstensionawal)|$(cat /deletedomainbaru).$(cat /deleteekstensionbaru)|g' robots.txt" | bash -
echo "curl -L http://$(cat /deleteipawal)/wp_$(cat /deletedomainawal)$(cat /deleteekstensionawal).sql | sed -e 's/$(cat /deletedomainawal).$(cat /deleteekstensionawal)/$(cat /deletedomainbaru).$(cat /deleteekstensionbaru)/g' -e 's/$(cat /deletedomainawal)/$(cat /deletedomainbaru)/g' > wp_$(cat /deletedomainbaru).sql" | bash -
chown -R www-data:www-data *
# Create database, ganti password, wordpressdb
echo "echo \"echo \\\"create database wp_\$(cat /deletedomainbaru); create user \$(cat /deleteuserdbbaru)@localhost identified by '\$(cat /deletepassdbbaru)'; grant all privileges on wp_\$(cat /deletedomainbaru).* to \$(cat /deleteuserdbbaru)@localhost identified by '\$(cat /deletepassdbbaru)'; flush privileges\\\" | mysql -u root \\\"-p\$(cat /deletepassmysql)\\\"\"" | bash - | bash -
echo "mysql -u $(cat /deleteuserdbbaru) \"-p$(cat /deletepassdbbaru)\" wp_$(cat /deletedomainbaru) < wp_$(cat /deletedomainbaru).sql" | bash -
echo "rm -f wp_$(cat /deletedomainbaru).sql" | bash -
rm -f domain.tar.gz
echo "UPDATE \`wp_posts\` SET \`post_status\` = 'draft' where \`post_status\` = 'publish' and \`post_type\` = 'post'; UPDATE \`wp_posts\` SET \`post_status\` = 'draft' where \`post_status\` = 'future' and \`post_type\` = 'post';" > deletemysql.sql
wp db query --allow-root < deletemysql.sql
wp plugin install drafts-scheduler --activate --allow-root
wp plugin install wp-missed-schedule --activate --allow-root
wp plugin update --all --allow-root
rm -f deletemysql.sql
wp core update-db --allow-root
wp plugin delete no-ping-wait wordpress-ping-optimizer wp-limit-login-attempts --allow-root
