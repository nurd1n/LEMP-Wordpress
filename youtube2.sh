cd /
clear && clear
#create password
passwd
#install x2go baru
apt-get update && apt-get -y install aptitude
sudo apt-get install apt-transport-https
apt-get install openssl
apt-get install gawk python-setuptools software-properties-common
sudo add-apt-repository ppa:x2go/stable
apt-get update
sudo apt-get install x2goserver x2goserver-xsession
apt-get install xorg lxde-core
#install yg diperlukan
sudo apt-get install ffmpeg
sudo apt-get install at sendmail midori bleachbit gedit terminator filezilla libimage-exiftool-perl unzip python-pip
easy_install pip
#install mechanize & beautifulsoup
pip install --upgrade mechanize
pip install --upgrade BeautifulSoup4
#install youtube-dl
pip install --upgrade youtube-dl
#install git
sudo apt-get install git-all
#folder upload
mkdir /root/upload
cd /root/upload
wget -q --no-check-certificate https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-64bit-static.tar.xz
tar xf ffmpeg-release-64bit-static.tar.xz
rm -f *.tar.xz
mv ffmpeg* ffmpeg-tool
cp ffmpeg-tool/ffmpeg /usr/bin/ffmpeg2
cp ffmpeg-tool/ffprobe /usr/bin/ffprobe2
touch live.sh
echo "1p" > start.txt
curl -L https://github.com/nurd1n/LEMP-Wordpress/raw/secret/youtube-start.sh -o start.sh
chmod 755 *.sh
mkdir data
mkdir data/description
mkdir data/thumbnail
touch data/url
touch data/title
touch data/tags
touch data/privacy
touch data/playlist
mkdir secret
touch secret/client.json
touch secret/channel.json
#clone xoxo
cd /root
git clone -b master https://github.com/nurd1n/Xoxo && cd Xoxo && chmod 755 *.sh
#install chrome
cd /tmp
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt-get -f install
#install names
pip install names
#ubah fonts
sudo apt-get install fonts-vlgothic
sudo fc-cache -f -v
#install youtube-upload
pip install --upgrade google-api-python-client progressbar2
curl -L https://github.com/tokland/youtube-upload/archive/master.zip -o master.zip
unzip master.zip
cd youtube-upload-master
python setup.py install
cd /tmp
#install Utorrent
curl -L https://github.com/nurd1n/LEMP-Wordpress/raw/secret/utserver.tar.gz -o utserver.tar.gz
tar xvzf utserver.tar.gz -C /tmp/
cd /tmp/utorrent*
unzip ./webui.zip
sudo su
chown -R root:root /tmp/utorrent*
mv /tmp/utorrent* /opt/utorrent
cd /opt/utorrent
sudo ./utserver
