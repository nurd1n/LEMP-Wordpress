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
#random plugin
tr -cd '[:alpha:]' < /dev/urandom | fold -w10 | head -n1 | sed -e 's/+/ /g' -e 's/.*/\L&/; s/[a-z]*/\u&/g' > /deletenameplugin
echo "echo '<?php /* Plugin Name: $(cat /deletenameplugin) */ ?>' > /home/www/$(cat /deletedomain)/wp-content/plugins/$(cat /deletenameplugin).php" | bash -
echo "wp plugin activate $(cat /deletenameplugin) --allow-root" | bash -
chown -R www-data:www-data *
wp plugin update --all --allow-root
#buat page
wp post create --post_type=page --post_title='Sitemap'  --post_content='[wpseo_html_sitemap]' --post_status='publish' --allow-root
echo "curl -L https://github.com/nurd1n/LEMP-Wordpress/raw/secret/extra | sed -e 's/domain1/$(cat /deletedomain)/g' -e 's/ekstension1/$(cat /deleteekstension)/g' > extra.sh" | bash -
chmod 755 extra.sh
./extra.sh
rm -f extra.sh
echo "chmod 777 /home/www/$(cat /deletedomain)" | bash -
echo "chmod 777 /home/www/$(cat /deletedomain)/wp-content" | bash -
