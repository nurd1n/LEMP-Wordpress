# Jalankan sql
echo "UPDATE wp_posts SET post_date = CURRENT_TIMESTAMP - INTERVAL FLOOR(RAND() * 180) DAY;" > deletemysql.sql
echo "UPDATE wp_posts SET post_date_gmt = CURRENT_TIMESTAMP - INTERVAL FLOOR(RAND() * 180) DAY;" >> deletemysql.sql
echo "UPDATE wp_posts SET post_modified = CURRENT_TIMESTAMP - INTERVAL FLOOR(RAND() * 180) DAY;" >> deletemysql.sql
echo "UPDATE wp_posts SET post_modified_gmt = CURRENT_TIMESTAMP - INTERVAL FLOOR(RAND() * 180) DAY;" >> deletemysql.sql
echo "DELETE FROM wp_posts WHERE post_content = \"\" AND post_type = \"post\";" >> deletemysql.sql
wp db query --allow-root < deletemysql.sql
# Hapus unused media
echo "SELECT ID FROM wp_posts WHERE post_content = \"\" AND post_type = \"attachment\";" > deletemysql.sql
wp db query --allow-root < deletemysql.sql | sed '1d' | sed 's/.*/wp post delete & --force --allow-root/' | bash -
rm -f delete*
# Hapus gambar 768x* : 
rm -f wp-content/uploads/*-768x*.jpg
rm -f wp-content/uploads/*-768x*.png
rm -f wp-content/uploads/*-768x*.gif
rm -f wp-content/uploads/*-768x*.jpeg
rm -f wp-content/uploads/*-768x*.bmp
rm -f wp-content/uploads/*-768x*.tif
rm -f wp-content/uploads/*-768x*.jpe
rm -f wp-content/uploads/*-768x*.JPG
rm -f wp-content/uploads/*-768x*.PNG
rm -f wp-content/uploads/*-768x*.GIF
rm -f wp-content/uploads/*-768x*.JPEG
rm -f wp-content/uploads/*-768x*.BMP
rm -f wp-content/uploads/*-768x*.TIF
rm -f wp-content/uploads/*-768x*.JPE
