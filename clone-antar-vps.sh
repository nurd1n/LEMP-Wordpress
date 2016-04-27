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
echo -n "Apa inisial blog lama anda (huruf kecil semua) :
"
read inisialawal
echo "$inisialawal" > deleteinisialawal; clear
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
echo -n "Apa inisial blog baru anda (huruf kecil semua) :
"
read inisialbaru
echo "$inisialbaru" > deleteinisialbaru; clear
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
echo "curl -L http://$(cat /deleteipawal)/secret > /deletesecret" | bash -
tar -zxvf domain.tar.gz
echo "sed -e 's|$(cat /deletedomainawal)|$(cat /deletedomainbaru)|g' -e 's|$(cat /deleteuserdbawal)|$(cat /deleteuserdbbaru)|g' -e 's|$(cat /deletepassdbawal)|$(cat /deletepassdbbaru)|g' wp-config.php > wp-config2.php" | bash -
rm -f wp-config.php
mv wp-config2.php wp-config.php
echo "sed -i 's|$(cat /deletedomainawal)\.$(cat /deleteekstensionawal)|$(cat /deletedomainbaru)\.$(cat /deleteekstensionbaru)|g' robots.txt" | bash -
echo "curl -L http://$(cat /deleteipawal)/wp_$(cat /deletedomainawal)$(cat /deleteekstensionawal).sql > wp_$(cat /deletedomainbaru).sql" | bash -
chown -R www-data:www-data *
# Create database, ganti password, wordpressdb
echo "echo \"echo \\\"create database wp_\$(cat /deletedomainbaru); create user \$(cat /deleteuserdbbaru)@localhost identified by '\$(cat /deletepassdbbaru)'; grant all privileges on wp_\$(cat /deletedomainbaru).* to \$(cat /deleteuserdbbaru)@localhost identified by '\$(cat /deletepassdbbaru)'; flush privileges\\\" | mysql -u root \\\"-p\$(cat /deletepassmysql)\\\"\"" | bash - | bash -
echo "mysql -u $(cat /deleteuserdbbaru) \"-p$(cat /deletepassdbbaru)\" wp_$(cat /deletedomainbaru) < wp_$(cat /deletedomainbaru).sql" | bash -
echo "rm -f wp_$(cat /deletedomainbaru).sql" | bash -
rm -f domain.tar.gz
echo "UPDATE wp_posts SET post_content = replace(post_content,\"$(cat /deletedomainawal).$(cat /deleteekstensionawal)\",\"$(cat /deletedomainbaru).$(cat /deleteekstensionbaru)\");" > deletemysql.sql
echo "UPDATE wp_posts SET post_content = replace(post_content,\"$(cat /deletedomainawal)\",\"$(cat /deletedomainbaru)\");" >> deletemysql.sql
echo "UPDATE wp_posts SET post_content = replace(post_content,\"$(cat /deleteinisialawal)\",\"$(cat /deleteinisialbaru)\");" >> deletemysql.sql
echo "UPDATE wp_posts SET post_content = replace(post_content,\"$(cat /deleteinisialawal | sed -e 's/+/ /g' -e 's/.*/\L&/; s/[a-z]*/\u&/g')\",\"$(cat /deleteinisialbaru | sed -e 's/+/ /g' -e 's/.*/\L&/; s/[a-z]*/\u&/g')\");" >> deletemysql.sql
echo "UPDATE wp_postmeta SET meta_value = replace(meta_value,\"$(cat /deletedomainawal).$(cat /deleteekstensionawal)\",\"$(cat /deletedomainbaru).$(cat /deleteekstensionbaru)\");" >> deletemysql.sql
echo "UPDATE wp_postmeta SET meta_value = replace(meta_value,\"$(cat /deletedomainawal)\",\"$(cat /deletedomainbaru)\");" >> deletemysql.sql
echo "UPDATE wp_postmeta SET meta_value = replace(meta_value,\"$(cat /deleteinisialawal)\",\"$(cat /deleteinisialbaru)\");" >> deletemysql.sql
echo "UPDATE wp_postmeta SET meta_value = replace(meta_value,\"$(cat /deleteinisialawal | sed -e 's/+/ /g' -e 's/.*/\L&/; s/[a-z]*/\u&/g')\",\"$(cat /deleteinisialbaru | sed -e 's/+/ /g' -e 's/.*/\L&/; s/[a-z]*/\u&/g')\");" >> deletemysql.sql
echo "UPDATE wp_options SET option_value = replace(option_value,\"$(cat /deletedomainawal).$(cat /deleteekstensionawal)\",\"$(cat /deletedomainbaru).$(cat /deleteekstensionbaru)\");" >> deletemysql.sql
echo "UPDATE wp_options SET option_value = replace(option_value,\"$(cat /deletedomainawal)\",\"$(cat /deletedomainbaru)\");" >> deletemysql.sql
echo "UPDATE wp_options SET option_value = replace(option_value,\"$(cat /deleteinisialawal)\",\"$(cat /deleteinisialbaru)\");" >> deletemysql.sql
echo "UPDATE wp_options SET option_value = replace(option_value,\"$(cat /deleteinisialawal | sed -e 's/+/ /g' -e 's/.*/\L&/; s/[a-z]*/\u&/g')\",\"$(cat /deleteinisialbaru | sed -e 's/+/ /g' -e 's/.*/\L&/; s/[a-z]*/\u&/g')\");" >> deletemysql.sql
echo "UPDATE wp_options SET option_value = replace(option_value,\"$(cat /deletesecret)\",\"$(cat /etc/varnish/secret)\");" >> deletemysql.sql
wp db query --allow-root < deletemysql.sql
echo "UPDATE \`wp_posts\` SET \`post_status\` = 'draft' where \`post_status\` = 'publish' and \`post_type\` = 'post'; UPDATE \`wp_posts\` SET \`post_status\` = 'draft' where \`post_status\` = 'future' and \`post_type\` = 'post';" > deletemysql.sql
wp db query --allow-root < deletemysql.sql
wp plugin delete no-ping-wait wordpress-ping-optimizer wp-limit-login-attempts --allow-root
wp plugin update --all --allow-root
wp core update --version=4.5 --force --allow-root
wp core update-db --allow-root
echo "UPDATE wp_posts SET post_date = CURRENT_TIMESTAMP - INTERVAL FLOOR(RAND() * 100) DAY;" > deletemysql.sql
echo "UPDATE wp_posts SET post_date_gmt = CURRENT_TIMESTAMP - INTERVAL FLOOR(RAND() * 100) DAY;" >> deletemysql.sql
echo "UPDATE wp_posts SET post_modified = CURRENT_TIMESTAMP - INTERVAL FLOOR(RAND() * 100) DAY;" >> deletemysql.sql
echo "UPDATE wp_posts SET post_modified_gmt = CURRENT_TIMESTAMP - INTERVAL FLOOR(RAND() * 100) DAY;" >> deletemysql.sql
wp db query --allow-root < deletemysql.sql
echo "UPDATE \`wp_posts\` SET \`post_status\` = 'publish' where \`post_status\` = 'draft' and \`post_type\` = 'post';" > deletemysql.sql
wp db query --allow-root < deletemysql.sql
rm -f *.sql
rm -f read*
rm -f license.txt
