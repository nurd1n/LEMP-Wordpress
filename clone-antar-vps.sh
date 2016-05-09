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
echo "UPDATE wp_posts SET post_content = replace(post_content,\"$(cat /deletedomainawal).$(cat /deleteekstensionawal)\",\"$(cat /deletedomainbaru).$(cat /deleteekstensionbaru)\");" > deletemysql.sql
echo "UPDATE wp_posts SET post_content = replace(post_content,\"$(cat /deletedomainawal)\",\"$(cat /deletedomainbaru)\");" >> deletemysql.sql
echo "UPDATE wp_posts SET post_content = replace(post_content,\"$(cat /deleteinisialawal) \",\"$(cat /deleteinisialbaru) \");" >> deletemysql.sql
echo "UPDATE wp_posts SET post_content = replace(post_content,\" $(cat /deleteinisialawal)\",\" $(cat /deleteinisialbaru)\");" >> deletemysql.sql
echo "UPDATE wp_posts SET post_content = replace(post_content,\"$(cat /deleteinisialawal | sed -e 's/+/ /g' -e 's/.*/\L&/; s/[a-z]*/\u&/g')\",\"$(cat /deleteinisialbaru | sed -e 's/+/ /g' -e 's/.*/\L&/; s/[a-z]*/\u&/g')\");" >> deletemysql.sql
echo "UPDATE wp_postmeta SET meta_value = replace(meta_value,\"$(cat /deletedomainawal).$(cat /deleteekstensionawal)\",\"$(cat /deletedomainbaru).$(cat /deleteekstensionbaru)\");" >> deletemysql.sql
echo "UPDATE wp_postmeta SET meta_value = replace(meta_value,\"$(cat /deletedomainawal)\",\"$(cat /deletedomainbaru)\");" >> deletemysql.sql
echo "UPDATE wp_postmeta SET meta_value = replace(meta_value,\"$(cat /deleteinisialawal) \",\"$(cat /deleteinisialbaru) \");" >> deletemysql.sql
echo "UPDATE wp_postmeta SET meta_value = replace(meta_value,\" $(cat /deleteinisialawal)\",\" $(cat /deleteinisialbaru)\");" >> deletemysql.sql
echo "UPDATE wp_postmeta SET meta_value = replace(meta_value,\"$(cat /deleteinisialawal | sed -e 's/+/ /g' -e 's/.*/\L&/; s/[a-z]*/\u&/g')\",\"$(cat /deleteinisialbaru | sed -e 's/+/ /g' -e 's/.*/\L&/; s/[a-z]*/\u&/g')\");" >> deletemysql.sql
echo "UPDATE wp_options SET option_value = replace(option_value,\"$(cat /deletedomainawal).$(cat /deleteekstensionawal)\",\"$(cat /deletedomainbaru).$(cat /deleteekstensionbaru)\");" >> deletemysql.sql
echo "UPDATE wp_options SET option_value = replace(option_value,\"$(cat /deletedomainawal)\",\"$(cat /deletedomainbaru)\");" >> deletemysql.sql
echo "UPDATE wp_options SET option_value = replace(option_value,\"$(cat /deleteinisialawal) \",\"$(cat /deleteinisialbaru) \");" >> deletemysql.sql
echo "UPDATE wp_options SET option_value = replace(option_value,\" $(cat /deleteinisialawal)\",\" $(cat /deleteinisialbaru)\");" >> deletemysql.sql
echo "UPDATE wp_options SET option_value = replace(option_value,\"$(cat /deleteinisialawal | sed -e 's/+/ /g' -e 's/.*/\L&/; s/[a-z]*/\u&/g')\",\"$(cat /deleteinisialbaru | sed -e 's/+/ /g' -e 's/.*/\L&/; s/[a-z]*/\u&/g')\");" >> deletemysql.sql
echo "UPDATE wp_options SET option_value = replace(option_value,\"$(cat /deletesecret)\",\"$(cat /etc/varnish/secret)\");" >> deletemysql.sql
wp db query --allow-root < deletemysql.sql
echo "UPDATE \`wp_posts\` SET \`post_status\` = 'draft' where \`post_status\` = 'publish' and \`post_type\` = 'post'; UPDATE \`wp_posts\` SET \`post_status\` = 'draft' where \`post_status\` = 'future' and \`post_type\` = 'post';" > deletemysql.sql
wp db query --allow-root < deletemysql.sql
wp plugin delete no-ping-wait wordpress-ping-optimizer wp-limit-login-attempts --allow-root
wp plugin update --all --allow-root
wp core update --version=4.5 --force --allow-root
wp core update-db --allow-root
echo "UPDATE wp_posts SET post_date = CURRENT_TIMESTAMP - INTERVAL FLOOR(RAND() * 180) DAY;" > deletemysql.sql
echo "UPDATE wp_posts SET post_date_gmt = CURRENT_TIMESTAMP - INTERVAL FLOOR(RAND() * 180) DAY;" >> deletemysql.sql
echo "UPDATE wp_posts SET post_modified = CURRENT_TIMESTAMP - INTERVAL FLOOR(RAND() * 180) DAY;" >> deletemysql.sql
echo "UPDATE wp_posts SET post_modified_gmt = CURRENT_TIMESTAMP - INTERVAL FLOOR(RAND() * 180) DAY;" >> deletemysql.sql
wp db query --allow-root < deletemysql.sql
echo "UPDATE \`wp_posts\` SET \`post_status\` = 'publish' where \`post_status\` = 'draft' and \`post_type\` = 'post';" > deletemysql.sql
wp db query --allow-root < deletemysql.sql
#install & activate theme
printf "Rosas\nRoses\nRosis\nRosus\nRosos" | shuf -n 1 > /deletetheme
echo "curl -L http://moviestreamfullhd.com/theme/$(cat /deletetheme).zip -o /home/www/$(cat /deletedomain)/wp-content/themes/$(cat /deletetheme).zip" | bash -
eval $(echo "cd /home/www/$(cat /deletedomain)/wp-content/themes")
echo "unzip $(cat /deletetheme)" | bash -
echo "rm -f $(cat /deletetheme).zip" | bash -
tr -cd '[:alpha:]' < /dev/urandom | fold -w10 | head -n1 | sed -e 's/+/ /g' -e 's/.*/\L&/; s/[a-z]*/\u&/g' > /deletenametheme
tr -cd '[:alpha:]' < /dev/urandom | fold -w10 | head -n1 | tr A-Z a-z > /deleteimagefolder
tr -cd '[:alpha:]' < /dev/urandom | fold -w10 | head -n1 | tr A-Z a-z > /deleteimagedefault
tr -cd '[:alpha:]' < /dev/urandom | fold -w10 | head -n1 | tr A-Z a-z > /deletespincomment
tr -cd '[:alpha:]' < /dev/urandom | fold -w10 | head -n1 | tr A-Z a-z > /deletespinfooter
tr -cd '[:alpha:]' < /dev/urandom | fold -w10 | head -n1 | tr A-Z a-z > /deletespinwidget
tr -cd '[:alpha:]' < /dev/urandom | fold -w10 | head -n1 | tr A-Z a-z > /deletespinwrapper
tr -cd '[:alpha:]' < /dev/urandom | fold -w10 | head -n1 | tr A-Z a-z > /deletespinheader
tr -cd '[:alpha:]' < /dev/urandom | fold -w10 | head -n1 | tr A-Z a-z > /deletespinvideo-container
tr -cd '[:alpha:]' < /dev/urandom | fold -w10 | head -n1 | tr A-Z a-z > /deletespinsite
tr -cd '[:alpha:]' < /dev/urandom | fold -w10 | head -n1 | tr A-Z a-z > /deletesearch
tr -cd '[:alpha:]' < /dev/urandom | fold -w10 | head -n1 | tr A-Z a-z > /deletecontent
tr -cd '[:alpha:]' < /dev/urandom | fold -w10 | head -n1 | tr A-Z a-z > /deletesingle
tr -cd '[:alpha:]' < /dev/urandom | fold -w10 | head -n1 | tr A-Z a-z > /deletepost
tr -cd '[:alpha:]' < /dev/urandom | fold -w10 | head -n1 | tr A-Z a-z > /deletenav
tr -cd '[:alpha:]' < /dev/urandom | fold -w10 | head -n1 | tr A-Z a-z > /deletetags
tr -cd '[:alpha:]' < /dev/urandom | fold -w10 | head -n1 | tr A-Z a-z > /deletetitle
tr -cd '[:alpha:]' < /dev/urandom | fold -w10 | head -n1 | tr A-Z a-z > /deletebottom-ads
tr -cd '[:alpha:]' < /dev/urandom | fold -w10 | head -n1 | tr A-Z a-z > /deleterandom
tr -cd '[:alpha:]' < /dev/urandom | fold -w10 | head -n1 | tr A-Z a-z > /deletesidebar
echo "mv $(cat /deletetheme) $(cat /deletenametheme)" | bash -
echo "mv $(cat /deletenametheme)/images $(cat /deletenametheme)/$(cat /deleteimagefolder)" | bash -
eval $(echo "cd /home/www/$(cat /deletedomain)/wp-content/themes/$(cat /deletenametheme)/$(cat /deleteimagefolder)")
echo "ffmpeg -i default-featured-image.jpg -vf \"setdar=$(shuf -i 20-80 -n 1):$(shuf -i 20-80 -n 1)\" $(cat /deleteimagedefault).jpg" | bash -
rm -f default-featured-image.jpg
eval $(echo "cd /home/www/$(cat /deletedomain)/wp-content/themes")
echo "sed -i 's|$(cat /deletetheme)|$(cat /deletenametheme)|g' /home/www/$(cat /deletedomain)/wp-content/themes/$(cat /deletenametheme)/style.css" | bash -
echo "mv $(cat /deletenametheme)/style.css $(cat /deletenametheme)/style2.css" | bash -
echo "shuf $(cat /deletenametheme)/style2.css > $(cat /deletenametheme)/style.css" | bash -
echo "rm -f $(cat /deletenametheme)/style2.css" | bash -
echo "sed -i 's|$(cat /deletetheme)|$(cat /deletenametheme)|g' /home/www/$(cat /deletedomain)/wp-content/themes/$(cat /deletenametheme)/comments.php" | bash -
echo "curl -L https://github.com/nurd1n/LEMP-Wordpress/raw/secret/function | shuf | awk 'FNR==1{print \"<?php\"}{print}' | sed '$ a ?>' | sed 's|hrqshn|$(cat /deletedomain)|g' > /home/www/$(cat /deletedomain)/wp-content/themes/$(cat /deletenametheme)/functions.php" | bash -
curl -L https://github.com/nurd1n/LEMP-Wordpress/raw/secret/responsive1 | shuf | awk 'FNR==1{print "@media only screen and (min-width: 768px) and (max-width: 960px) {"}{print}' | sed '$ a }' > /deletethemeres
curl -L https://github.com/nurd1n/LEMP-Wordpress/raw/secret/responsive2 | shuf | awk 'FNR==1{print "@media only screen and (max-width: 767px) {"}{print}' | sed '$ a }' >> /deletethemeres
curl -L https://github.com/nurd1n/LEMP-Wordpress/raw/secret/responsive3 | shuf | awk 'FNR==1{print "@media only screen and (min-width: 480px) and (max-width: 767px) {"}{print}' | sed '$ a }' >> /deletethemeres
echo "cat /deletethemeres | awk 'FNR==1{print \"/* Theme Name: $(cat /deletenametheme) */\"}{print}' > /home/www/$(cat /deletedomain)/wp-content/themes/$(cat /deletenametheme)/responsive.css" | bash -
echo "sed -i -e 's|id=\"comments\"|id=\"$(cat /deletespincomment)s\"|g' -e 's|class=\"comments-area\"|class=\"$(cat /deletespincomment)s-area\"|g' -e 's|class=\"comments-title\"|class=\"$(cat /deletespincomment)s-title\"|g' -e 's|id=\"comment-nav-above\"|id=\"$(cat /deletespincomment)-nav-above\"|g' -e 's|class=\"navigation comment-navigation\"|class=\"navigation $(cat /deletespincomment)-navigation\"|g' -e 's|class=\"screen-reader-text\"|class=\"$(tr -cd '[:alpha:]' < /dev/urandom | fold -w10 | head -n1 | tr A-Z a-z)\"|g' -e 's|class=\"nav-previous\"|class=\"$(cat /deletenav)-previous\"|g' -e 's|class=\"nav-next\"|class=\"$(cat /deletenav)-next\"|g' -e 's|class=\"navleft\"|class=\"$(cat /deletenav)left\"|g' -e 's|class=\"navright\"|class=\"$(cat /deletenav)right\"|g' -e 's|id=\"comment-nav-below\"|id=\"$(cat /deletespincomment)-nav-below\"|g' -e 's|class=\"comment-list\"|class=\"$(cat /deletespincomment)-list\"|g' -e 's|class=\"no-comments\"|class=\"no-$(cat /deletespincomment)s\"|g' -e 's|One thought on|$(printf 'One thought on\nOne opinion on\nOne reason on\nOne diquss on' | shuf -n 1)|g' -e 's|thought on|$(printf 'thoughts on\nopinion on\nreason on\ndiquss on' | shuf -n 1)|g' -e 's|Comment navigation|$(printf 'Comment navigation\nOpinion navigation\nReason navigation\nDisquss navigation' | shuf -n 1)|g' -e 's|Older Comments|$(printf 'Older Comments\nOlder Opinion\nOlder Reason\nOlder Disquss '| shuf -n 1)|g' -e 's|Newer Comments|$(printf 'Newer Comments\nNewer Opinion\nNewer Reason\nNewer Disquss' | shuf -n 1)|g' -e 's|Comments are closed|$(printf 'Comments are closed\nOpinion are closed\nReason are closed\nDisquss are closed' | shuf -n 1)|g' -e 's|class=\"footer\"|class=\"$(cat /deletespinfooter)\"|g' -e 's|class=\"footer-copy\"|class=\"$(cat /deletespinfooter)-copy\"|g' -e 's|class=\"footer-menu\"|class=\"$(cat /deletespinfooter)-menu\"|g' -e 's|class=\"widget|class=\"$(cat /deletespinwidget)|g' -e 's|class=\"video-container\"|class=\"$(cat /deletespinvideo-container)\"|g' -e 's|class=\"wrapper\"|class=\"$(cat /deletespinwrapper)\"|g' -e 's|class=\"header\"|class=\"$(cat /deletespinheader)\"|g' -e 's|class=\"site-|class=\"$(cat /deletespinsite)-|g' -e 's|class=\"search-form\"|class=\"$(cat /deletesearch)-form\"|g' -e 's|id=\"searchsubmit\"|id=\"$(cat /deletesearch)submit\"|g' -e 's|class=\"header-ads\"|class=\"$(cat /deletespinheader)-ads\"|g' -e 's|class=\"content\"|class=\"$(cat /deletecontent)\"|g' -e 's|class=\"entry-content\"|class=\"entry-$(cat /deletecontent)\"|g' -e 's|class=\"single-|class=\"$(cat /deletesingle)-|g' -e 's|class=\"single\"|class=\"$(cat /deletesingle)\"|g' -e 's|class=\"post-|class=\"$(cat /deletepost)-|g' -e 's|class=\"post\"|class=\"$(cat /deletepost)\"|g' -e 's|class=\"page-post\"|class=\"page-$(cat /deletepost)\"|g' -e 's|class=\"tags\"|class=\"$(cat /deletetags)\"|g' -e 's|class=\"title\"|class=\"$(cat /deletetitle)\"|g' -e 's|class=\"bottom-ads\"|class=\"$(cat /deletebottom-ads)\"|g' -e 's|class=\"random\"|class=\"$(cat /deleterandom)\"|g' -e 's|class=\"sidebar\"|class=\"$(cat /deleterandom)\"|g' -e 's|Upload a logo to replace the default site name and description in the header|$(tr -cd '[:alpha:]' < /dev/urandom | fold -w10 | head -n1 | tr A-Z a-z)|g' -e 's|Drag a Text Widget here and copy your Adsense ads|$(tr -cd '[:alpha:]' < /dev/urandom | fold -w10 | head -n1 | tr A-Z a-z)|g' -e 's|Sitemap|$(cat /deletedomain) Sitemap|g' -e 's|404|$(tr -cd '[:alpha:]' < /dev/urandom | fold -w10 | head -n1 | tr A-Z a-z)|g' -e 's|All Posts|$(printf 'All posts\nAll article\nall posts\nall article' | shuf -n 1)|g' -e 's|Previous page|$(printf 'Previous page\nPrevious\nprevious page\nprevious' | shuf -n 1)|g' -e 's|Next page|$(printf 'Next page\nNext\nnext page\nnext' | shuf -n 1)|g' -e 's|Search site|$(printf 'Search site\nSearch\nSearch here\nSearch image' | shuf -n 1)|g' -e 's|More Images|$(printf 'More Images\nOther Images\nMore\nOther' | shuf -n 1)|g' -e 's|class=\"nav\"|class=\"$(cat /deletenav)\"|g' -e 's|#000000|$(printf '#1e73be\n#1e69bf\n#1d50b7\n#203fc9\n#2333e0\n#205ec9\n#1c59b5\n#3520d6\n#3b1dc1\n#1933a8' | shuf -n 1)|g' -e 's|#59af03|$(printf '#4a9603\n#518202\n#03af28\n#04d315\n#9e03b2\n#03a834\n#399102\n#3f7201\n#077c01\n#269301' | shuf -n 1)|g' -e 's|/images/default-featured-image|/$(cat /deleteimagefolder)/$(cat /deleteimagedefault)|g' *.php" | bash -
echo "sed -i -e 's|.search-form|.$(cat /deletesearch)-form|g' -e 's|.content|.$(cat /deletecontent)|g' -e 's|.nav|.$(cat /deletenav)|g' -e 's|.wrapper|.$(cat /deletespinwrapper)|g' -e 's|.site-|.$(cat /deletespinsite)-|g' -e 's|.post-|.$(cat /deletepost)-|g' -e 's|.post|.$(cat /deletepost)|g' -e 's|.sidebar|.$(cat /deletesidebar)|g' -e 's|.single-|.$(cat /deletesingle)-|g' -e 's|.single|.$(cat /deletesingle)|g' -e 's|.tags|.$(cat /deletetags)|g' -e 's|.footer|.$(cat /deletespinfooter)|g' -e 's|.widget|.$(cat /deletespinwidget)|g' -e 's|.random|.$(cat /deleterandom)|g' -e 's|comment|$(cat /deletespincomment)|g' -e 's|.footer-copy|.$(cat /deletespinfooter)-copy|g' -e 's|.footer-menu|.$(cat /deletespinfooter)-menu|g' -e 's|.video-container|.$(cat /deletespinvideo-container)|g' -e 's|.header-ads|.$(cat /deletespinheader)-ads|g' -e 's|.bottom-ads|.$(cat /deletebottom-ads)|g' -e 's|.header|.$(cat /deletespinheader)|g' *.css" | bash -
eval $(echo "cd /home/www/$(cat /deletedomain)")
echo "wp theme activate $(cat /deletenametheme) --allow-root" | bash -
#delete theme unactive
wp theme delete $(wp theme list --status=inactive --field=name --allow-root) --allow-root
rm -f *.sql
rm -f read*
rm -f license.txt
rm -f domain.tar.gz
shred -v -n 25 -u -z *.xml
shred -v -n 25 -u -z *.xml.gz
#random plugin
tr -cd '[:alpha:]' < /dev/urandom | fold -w10 | head -n1 | sed -e 's/+/ /g' -e 's/.*/\L&/; s/[a-z]*/\u&/g' > /deletenameplugin
echo "echo '<?php /* Plugin Name: $(cat /deletenameplugin) */ ?>' > /home/www/$(cat /deletedomain)/wp-content/plugins/$(cat /deletenameplugin).php" | bash -
echo "wp plugin activate $(cat /deletenameplugin) --allow-root" | bash -
wp plugin update --all --allow-root
echo "chmod 777 /home/www/$(cat /deletedomain)" | bash -
echo "chmod 777 /home/www/$(cat /deletedomain)/wp-content" | bash -
